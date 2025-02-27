local E = unpack(ElvUI)
local _G = _G
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local A = E:GetModule('Auras')
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local select = _G.select
local C_ChatBubbles = _G.C_ChatBubbles

local EltruismBlizzShadows = CreateFrame("Frame")
local MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
local RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
local LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
local timermonitor = CreateFrame("FRAME")
local valuecolors = E:ClassColor(E.myclass, true)
local DT = E:GetModule('DataTexts')

--simple function to set shadow color
function ElvUI_EltreumUI:ShadowColor(shadow)
	if shadow then
		if E.db.ElvUI_EltreumUI.skins.shadow.classcolor then
			shadow:SetBackdropBorderColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
		elseif E.db.ElvUI_EltreumUI.skins.shadow.customcolor then
			shadow:SetBackdropBorderColor(E.db.ElvUI_EltreumUI.skins.shadow.r, E.db.ElvUI_EltreumUI.skins.shadow.g, E.db.ElvUI_EltreumUI.skins.shadow.b, E.db.ElvUI_EltreumUI.skins.shadow.a)
		end
	end
end

--Frame Shadows, turns out ElvUI includes the function
function ElvUI_EltreumUI:Shadows()
	if E.db.ElvUI_EltreumUI.skins.shadow.enable then
		local benikdettached = false
		if IsAddOnLoaded("ElvUI_BenikUI") then
			benikdettached = E.db.benikui.unitframes.player.detachPortrait
		end
		------------------------------------------------------------------------------------------------------blizzard frames
		if E.db.ElvUI_EltreumUI.skins.shadow.blizzard and E.private.skins.blizzard.enable then
			EltruismBlizzShadows:RegisterEvent("ADDON_LOADED")
			EltruismBlizzShadows:RegisterEvent("PLAYER_ENTERING_WORLD")
			EltruismBlizzShadows:SetScript("OnEvent", function(_, _, arg)
				if (arg == "WeakAurasOptions") or IsAddOnLoaded("WeakAurasOptions") then
					if IsAddOnLoaded("ElvUI_WindTools") then
						if E.private.WT.skins.addons.weakAuras then
							E:Delay(0, function()
								if _G["WeakAurasOptions"] and not _G["WeakAurasOptions"].shadow then
									_G["WeakAurasOptions"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G["WeakAurasOptions"].shadow)
								end
							end)
						end
					end
				end
				if E.private.skins.blizzard.enable then
					if (arg == "Blizzard_DelvesDifficultyPicker") or IsAddOnLoaded("Blizzard_DelvesDifficultyPicker") then
						if _G.DelvesDifficultyPickerFrame then
							if not _G.DelvesDifficultyPickerFrame.shadow then
								_G.DelvesDifficultyPickerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.DelvesDifficultyPickerFrame.shadow)
							end
						end
					end

					if (arg == "Blizzard_PlayerSpells") or IsAddOnLoaded("Blizzard_PlayerSpells") then
						if _G.PlayerSpellsFrame then
							if not _G.PlayerSpellsFrame.shadow then
								_G.PlayerSpellsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerSpellsFrame.shadow)
							end
							if _G.PlayerSpellsFrame.TabSystem then
								for i = 1, _G.PlayerSpellsFrame.TabSystem:GetNumChildren() do
									local tab = select(i, _G.PlayerSpellsFrame.TabSystem:GetChildren())
									if tab and tab.backdrop and not tab.backdrop.shadow then
										tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(tab.backdrop.shadow)
									end
								end
							end
						end
						if _G.HeroTalentsSelectionDialog then
							if not _G.HeroTalentsSelectionDialog.shadow then
								_G.HeroTalentsSelectionDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.HeroTalentsSelectionDialog.shadow)
							end
						end
					end
					if (arg == "Blizzard_ProfessionsBook") or IsAddOnLoaded("Blizzard_ProfessionsBook") then
						if _G.ProfessionsBookFrame then
							if not _G.ProfessionsBookFrame.shadow then
								_G.ProfessionsBookFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.ProfessionsBookFrame.shadow)
							end
						end
					end
					if (arg == "Blizzard_ScrappingMachineUI") or IsAddOnLoaded("Blizzard_ScrappingMachineUI") then
						if _G.ScrappingMachineFrame and not _G.ScrappingMachineFrame.shadow then
							_G.ScrappingMachineFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ScrappingMachineFrame.shadow)
						end
					end
					if (arg == "Blizzard_EngravingUI") or IsAddOnLoaded("Blizzard_EngravingUI") then
						if _G.EngravingFrame and _G.EngravingFrame.backdrop and not _G.EngravingFrame.backdrop.shadow then
							_G.EngravingFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EngravingFrame.backdrop.shadow)
						end
					end
					if (arg == "Blizzard_AdventureMap") or IsAddOnLoaded("Blizzard_AdventureMap") then
						if _G.AdventureMapQuestChoiceDialog and not _G.AdventureMapQuestChoiceDialog.shadow then
							_G.AdventureMapQuestChoiceDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AdventureMapQuestChoiceDialog.shadow)
						end
					end
					if (arg == "Blizzard_BattlefieldMap") or IsAddOnLoaded("Blizzard_BattlefieldMap") then
						if _G.BattleFieldFrame and _G.BattleFieldFrame.backdrop then
							if not _G.BattleFieldFrame.backdrop.shadow then
								_G.BattleFieldFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.BattleFieldFrame.backdrop.shadow)
							end
						end
						if _G.BattlefieldMapFrame and _G.BattlefieldMapFrame.backdrop then
							if not _G.BattlefieldMapFrame.backdrop.shadow then
								_G.BattlefieldMapFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.BattlefieldMapFrame.backdrop.shadow)
							end
						end
						if _G.BattlefieldMapTab and _G.BattlefieldMapTab.backdrop then
							if not _G.BattlefieldMapTab.backdrop.shadow then
								_G.BattlefieldMapTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.BattlefieldMapTab.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_ArtifactUI") or IsAddOnLoaded("Blizzard_ArtifactUI") then
						if _G.ArtifactFrame and not _G.ArtifactFrame.shadow then
							_G.ArtifactFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ArtifactFrame.shadow)
						end
						if _G.ArtifactFrameTab1 and _G.ArtifactFrameTab1.backdrop and not _G.ArtifactFrameTab1.backdrop.shadow then
							_G.ArtifactFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ArtifactFrameTab1.backdrop.shadow)
						end
						if _G.ArtifactFrameTab2 and _G.ArtifactFrameTab2.backdrop and not _G.ArtifactFrameTab2.backdrop.shadow then
							_G.ArtifactFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ArtifactFrameTab2.backdrop.shadow)
						end
					end
					if (arg == "Blizzard_PerksProgram") or IsAddOnLoaded("Blizzard_PerksProgram") then
						if _G.PerksProgramFrame then
							if _G.PerksProgramFrame.ProductsFrame then
								if _G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame and not _G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.shadow then
									_G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.shadow)
								end
								if _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter then
									if _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton and not _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton.shadow then
										_G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton.shadow)
									end
								end
								if _G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer and not _G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.shadow then
									_G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.shadow)
								end
								if _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame and not _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow then
									_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:ClearAllPoints()
									_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:SetPoint("TOPLEFT", _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.Icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.Icon, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow)
								end
							end
							if _G.PerksProgramFrame.FooterFrame then
								if _G.PerksProgramFrame.FooterFrame.PurchaseButton and not _G.PerksProgramFrame.FooterFrame.PurchaseButton.shadow then
									_G.PerksProgramFrame.FooterFrame.PurchaseButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.PurchaseButton.shadow)
								end
								if _G.PerksProgramFrame.FooterFrame.ToggleHideArmor.backdrop and not _G.PerksProgramFrame.FooterFrame.ToggleHideArmor.backdrop.shadow then
									_G.PerksProgramFrame.FooterFrame.ToggleHideArmor.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.ToggleHideArmor.backdrop.shadow)
								end
								if _G.PerksProgramFrame.FooterFrame.LeaveButton and not _G.PerksProgramFrame.FooterFrame.LeaveButton.shadow then
									_G.PerksProgramFrame.FooterFrame.LeaveButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.LeaveButton.shadow)
								end
								if _G.PerksProgramFrame.FooterFrame.ToggleAttackAnimation and _G.PerksProgramFrame.FooterFrame.ToggleAttackAnimation.backdrop and not _G.PerksProgramFrame.FooterFrame.ToggleAttackAnimation.backdrop.shadow then
									_G.PerksProgramFrame.FooterFrame.ToggleAttackAnimation.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.ToggleAttackAnimation.backdrop.shadow)
								end
								if _G.PerksProgramFrame.FooterFrame.ToggleMountSpecial and _G.PerksProgramFrame.FooterFrame.ToggleMountSpecial.backdrop and not _G.PerksProgramFrame.FooterFrame.ToggleMountSpecial.backdrop.shadow then
									_G.PerksProgramFrame.FooterFrame.ToggleMountSpecial.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.ToggleMountSpecial.backdrop.shadow)
								end
								if _G.PerksProgramFrame.FooterFrame and _G.PerksProgramFrame.FooterFrame.RotateButtonContainer then
									if _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton and not _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton.shadow then
										_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton.shadow)
									end
									if _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton and not _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton.shadow then
										_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton.shadow)
									end
									if (_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview and _G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop) and not _G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop.shadow then
										_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop.shadow)
									end
								end
							end
						end
					end
					if (arg == "Blizzard_ProfessionsCustomerOrders") or IsAddOnLoaded("Blizzard_ProfessionsCustomerOrders") then
						if _G.ProfessionsCustomerOrdersFrame and not _G.ProfessionsCustomerOrdersFrame.shadow then
							_G.ProfessionsCustomerOrdersFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ProfessionsCustomerOrdersFrame.shadow)
						end
						if _G.ProfessionsCustomerOrdersFrameBrowseTab and _G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop and not _G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop.shadow then
							_G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop.shadow)
						end
						if _G.ProfessionsCustomerOrdersFrameOrdersTab and _G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop and not _G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop.shadow then
							_G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop.shadow)
						end

						if _G.ProfessionsCustomerOrdersFrame and _G.ProfessionsCustomerOrdersFrame.Form and _G.ProfessionsCustomerOrdersFrame.Form.QualityDialog and not _G.ProfessionsCustomerOrdersFrame.Form.QualityDialog.shadow then
							_G.ProfessionsCustomerOrdersFrame.Form.QualityDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ProfessionsCustomerOrdersFrame.Form.QualityDialog.shadow)
						end
					end
					if (arg == "Blizzard_GenericTraitUI") or IsAddOnLoaded("Blizzard_GenericTraitUI") then
						if _G.GenericTraitFrame and not _G.GenericTraitFrame.shadow then
							_G.GenericTraitFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.GenericTraitFrame.shadow)
						end
					end
					if (arg == "Blizzard_TalkingHeadUI") or IsAddOnLoaded("Blizzard_TalkingHeadUI") then
						if _G.TalkingHeadFrame and not _G.TalkingHeadFrame.shadow then
							_G.TalkingHeadFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.TalkingHeadFrame.shadow)
						end
					end
					if (arg == "Blizzard_ClassTalentUI") or IsAddOnLoaded("Blizzard_ClassTalentUI") then
						if _G.ClassTalentFrame and not _G.ClassTalentFrame.shadow then
							_G.ClassTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ClassTalentFrame.shadow)
							if _G.ClassTalentFrame.TabSystem then
								for i = 1, _G.ClassTalentFrame.TabSystem:GetNumChildren() do
									local tab = select(i, _G.ClassTalentFrame.TabSystem:GetChildren())
									if tab and tab.backdrop and not tab.backdrop.shadow then
										tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(tab.backdrop.shadow)
									end
								end
							end
						end
						if _G.ClassTalentLoadoutImportDialog then
							_G.ClassTalentLoadoutImportDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ClassTalentLoadoutImportDialog.shadow)
						end
					end
					if (arg == "Blizzard_ItemInteractionUI") or IsAddOnLoaded("Blizzard_ItemInteractionUI") then
						if _G.ItemInteractionFrame and not _G.ItemInteractionFrame.shadow then
							_G.ItemInteractionFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ItemInteractionFrame.shadow)
						end
					end
					if (arg == "Blizzard_OrderHallUI") or IsAddOnLoaded("Blizzard_OrderHallUI") then
						if _G.OrderHallCommandBar and not _G.OrderHallCommandBar.shadow then
							_G.OrderHallCommandBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.OrderHallCommandBar.shadow)
						end
						if _G.OrderHallTalentFrame and not _G.OrderHallTalentFrame.shadow then
							_G.OrderHallTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.OrderHallTalentFrame.shadow)
						end
					end
					if (arg == "Blizzard_ArchaeologyUI") or IsAddOnLoaded("Blizzard_ArchaeologyUI") then
						if _G.ArcheologyDigsiteProgressBar and _G.ArcheologyDigsiteProgressBar.FillBar and not _G.ArcheologyDigsiteProgressBar.FillBar.shadow then
							_G.ArcheologyDigsiteProgressBar.FillBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ArcheologyDigsiteProgressBar.FillBar.shadow)
						end
						if _G.ArchaeologyFrame and not _G.ArchaeologyFrame.shadow then
							_G.ArchaeologyFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ArchaeologyFrame.shadow)
						end
					end
					if (arg == "Blizzard_MacroUI") or IsAddOnLoaded("Blizzard_MacroUI") then
						if E.Retail or E.Cata then
							if not _G.MacroFrame.shadow then
								_G.MacroFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.MacroFrame.shadow)
							end
						elseif E.Classic then
							if _G.MacroFrame and _G.MacroFrame.backdrop and not _G.MacroFrame.backdrop.shadow then
								_G.MacroFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.MacroFrame.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_DeathRecap") or IsAddOnLoaded("Blizzard_DeathRecap") then
						if not _G.DeathRecapFrame.shadow then
							_G.DeathRecapFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.DeathRecapFrame.shadow)
						end
					end
					if (arg == "Blizzard_FlightMap") or IsAddOnLoaded("Blizzard_FlightMap") then
						if not _G.FlightMapFrame.shadow then
							_G.FlightMapFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.FlightMapFrame.shadow)
						end
					end
					if (arg == "Blizzard_GuildBankUI") or IsAddOnLoaded("Blizzard_GuildBankUI") then
						if E.Retail or E.Cata then
							if E.Retail then
								if not _G.GuildBankFrame.shadow then
									_G.GuildBankFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrame.shadow)
								end
							else
								if _G.GuildBankFrame.backdrop and not _G.GuildBankFrame.backdrop.shadow then
									_G.GuildBankFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrame.backdrop.shadow)
								end
							end
							if not _G.GuildBankTab1.Button.shadow then
								_G.GuildBankTab1.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab1.Button.shadow)
							end
							if not _G.GuildBankTab2.Button.shadow then
								_G.GuildBankTab2.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab2.Button.shadow)
							end
							if not _G.GuildBankTab3.Button.shadow then
								_G.GuildBankTab3.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab3.Button.shadow)
							end
							if not _G.GuildBankTab4.Button.shadow then
								_G.GuildBankTab4.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab4.Button.shadow)
							end
							if not _G.GuildBankTab5.Button.shadow then
								_G.GuildBankTab5.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab5.Button.shadow)
							end
							if not _G.GuildBankTab6.Button.shadow then
								_G.GuildBankTab6.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankTab6.Button.shadow)
							end
							if _G.GuildBankFrameTab1.backdrop and not _G.GuildBankFrameTab1.backdrop.shadow then
								_G.GuildBankFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrameTab1.backdrop.shadow)
							end
							if _G.GuildBankFrameTab2.backdrop and not _G.GuildBankFrameTab2.backdrop.shadow then
								_G.GuildBankFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrameTab2.backdrop.shadow)
							end
							if _G.GuildBankFrameTab3.backdrop and not _G.GuildBankFrameTab3.backdrop.shadow then
								_G.GuildBankFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrameTab3.backdrop.shadow)
							end
							if _G.GuildBankFrameTab4.backdrop and not _G.GuildBankFrameTab4.backdrop.shadow then
								_G.GuildBankFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrameTab4.backdrop.shadow)
							end
						else
							if _G.GuildBankFrame.backdrop and not _G.GuildBankFrame.backdrop.shadow then
								_G.GuildBankFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GuildBankFrame.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_TrainerUI") or IsAddOnLoaded("Blizzard_TrainerUI") then
						if E.Retail then
							if not _G.ClassTrainerFrame.shadow then
								_G.ClassTrainerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.ClassTrainerFrame.shadow)
							end
						else
							if _G.ClassTrainerFrame.backdrop and not _G.ClassTrainerFrame.backdrop.shadow then
								_G.ClassTrainerFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.ClassTrainerFrame.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_ItemSocketingUI") or IsAddOnLoaded("Blizzard_ItemSocketingUI") then
						if not _G.ItemSocketingFrame.shadow then
							_G.ItemSocketingFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ItemSocketingFrame.shadow)
						end
					end
					if (arg == "Blizzard_ItemUpgradeUI") or IsAddOnLoaded("Blizzard_ItemUpgradeUI") then
						if not _G.ItemUpgradeFrame.shadow then
							_G.ItemUpgradeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ItemUpgradeFrame.shadow)
						end
					end
					if (arg == "Blizzard_TradeSkillUI") or IsAddOnLoaded("Blizzard_TradeSkillUI") then
						if E.Retail then
							if not _G.TradeSkillFrame.shadow then
								_G.TradeSkillFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.TradeSkillFrame.shadow)
							end
						else
							if _G.TradeSkillFrame.backdrop and not _G.TradeSkillFrame.backdrop.shadow then
								_G.TradeSkillFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.TradeSkillFrame.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_ChromieTimeUI") or IsAddOnLoaded("Blizzard_ChromieTimetUI") then
						if not _G.ChromieTimeFrame.shadow then
							_G.ChromieTimeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ChromieTimeFrame.shadow)
						end
					end
					if (arg == "Blizzard_BlackMarketUI") or IsAddOnLoaded("Blizzard_BlackMarketUI") then
						if not _G.BlackMarketFrame.shadow then
							_G.BlackMarketFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.BlackMarketFrame.shadow)
						end
					end
					if (arg == "Blizzard_BindingUI") or IsAddOnLoaded("Blizzard_BindingUI") then
						if not _G.KeyBindingFrame.shadow then
							_G.KeyBindingFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.KeyBindingFrame.shadow)
						end
					end
					if (arg == "Blizzard_InspectUI") or IsAddOnLoaded("Blizzard_InspectUI") then
						if E.Retail then
							if _G.InspectFrame and not _G.InspectFrame.shadow then
								_G.InspectFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.InspectFrame.shadow)
							end
						else
							if _G.InspectFrame and _G.InspectFrame.backdrop and not _G.InspectFrame.backdrop.shadow then
								_G.InspectFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.InspectFrame.backdrop.shadow)
							end
						end
						if _G.InspectFrameTab1 and _G.InspectFrameTab1.backdrop and not _G.InspectFrameTab1.backdrop.shadow then
							_G.InspectFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.InspectFrameTab1.backdrop.shadow)
						end
						if _G.InspectFrameTab2 and _G.InspectFrameTab2.backdrop and not _G.InspectFrameTab2.backdrop.shadow then
							_G.InspectFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.InspectFrameTab2.backdrop.shadow)
						end
						if _G.InspectFrameTab3 and _G.InspectFrameTab3.backdrop and not _G.InspectFrameTab3.backdrop.shadow then
							_G.InspectFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.InspectFrameTab3.backdrop.shadow)
						end
						if IsAddOnLoaded("ElvUI_WindTools") then
							if E.db.WT.item.inspect.inspect then
								if _G["InspectFrame"] then
									_G["InspectFrame"]:HookScript("OnShow", function()
										E:Delay(1, function()
											if _G["InspectFrame"].inspectFrame then
												if not _G["InspectFrame"].inspectFrame.shadow then
													_G["InspectFrame"].inspectFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
													ElvUI_EltreumUI:ShadowColor(_G["InspectFrame"].inspectFrame.shadow)
												end
												if _G["InspectFrame"].inspectFrame.statsFrame and not _G["InspectFrame"].inspectFrame.statsFrame.shadow then
													_G["InspectFrame"].inspectFrame.statsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
													ElvUI_EltreumUI:ShadowColor(_G["InspectFrame"].inspectFrame.statsFrame.shadow)
												end
											end
											if _G["InspectFrame"].inspectFrame and _G["InspectFrame"].inspectFrame.inspectFrame and not _G["InspectFrame"].inspectFrame.inspectFrame.shadow then
												_G["InspectFrame"].inspectFrame.inspectFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												ElvUI_EltreumUI:ShadowColor(_G["InspectFrame"].inspectFrame.inspectFrame.shadow)
											end
										end)
									end)
								end
							end
						end
					end
					if (arg == "Blizzard_TalentUI") or IsAddOnLoaded("Blizzard_TalentUI") then
						if E.Retail then
							if not _G.PlayerTalentFrame.shadow then
								_G.PlayerTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrame.shadow)
							end
						else
							if _G.PlayerTalentFrame and _G.PlayerTalentFrame.backdrop and not _G.PlayerTalentFrame.backdrop.shadow then
								_G.PlayerTalentFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrame.backdrop.shadow)
							end
							if _G.PlayerTalentFrameTab3 and _G.PlayerTalentFrameTab3.backdrop and not _G.PlayerTalentFrameTab3.backdrop.shadow then
								_G.PlayerTalentFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrameTab3.backdrop.shadow)
							end
							if _G.PlayerTalentFrameTab4 and _G.PlayerTalentFrameTab4.backdrop and not _G.PlayerTalentFrameTab4.backdrop.shadow then
								_G.PlayerTalentFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrameTab4.backdrop.shadow)
							end
							if _G.PlayerSpecTab1 and not _G.PlayerSpecTab1.shadow then
								_G.PlayerSpecTab1:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerSpecTab1.shadow)
							end
							if _G.PlayerSpecTab2 and not _G.PlayerSpecTab2.shadow then
								_G.PlayerSpecTab2:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.PlayerSpecTab2.shadow)
							end
						end
						if _G.PlayerTalentFrameTab1 and _G.PlayerTalentFrameTab1.backdrop and not _G.PlayerTalentFrameTab1.backdrop.shadow then
							_G.PlayerTalentFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrameTab1.backdrop.shadow)
						end
						if _G.PlayerTalentFrameTab2 and _G.PlayerTalentFrameTab2.backdrop and not _G.PlayerTalentFrameTab2.backdrop.shadow then
							_G.PlayerTalentFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.PlayerTalentFrameTab2.backdrop.shadow)
						end
					end
					if (arg == "Blizzard_Calendar") or IsAddOnLoaded("Blizzard_Calendar") then
						if not _G.CalendarFrame.shadow then
							_G.CalendarFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CalendarFrame.shadow)
						end
						if not _G.CalendarViewHolidayFrame.shadow then
							_G.CalendarViewHolidayFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CalendarViewHolidayFrame.shadow)
						end
						if _G.CalendarContextMenu then
							_G.CalendarContextMenu:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CalendarContextMenu.shadow)
						end
						if _G.CalendarCreateEventFrame then
							_G.CalendarCreateEventFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CalendarCreateEventFrame.shadow)
						end
					end
					if (arg == "Blizzard_Communities") or IsAddOnLoaded("Blizzard_Communities") then
						if _G.CommunitiesFrame then
							if not _G.CommunitiesFrame.shadow then
								_G.CommunitiesFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.shadow)
							end
							if _G.CommunitiesFrameTab1 and _G.CommunitiesFrameTab1.backdrop and not _G.CommunitiesFrameTab1.backdrop.shadow then
								_G.CommunitiesFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrameTab1.backdrop.shadow)
							end
							if _G.CommunitiesFrameTab2 and _G.CommunitiesFrameTab2.backdrop and not _G.CommunitiesFrameTab2.backdrop.shadow then
								_G.CommunitiesFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrameTab2.backdrop.shadow)
							end
							if _G.CommunitiesFrameTab3 and _G.CommunitiesFrameTab3.backdrop and not _G.CommunitiesFrameTab3.backdrop.shadow then
								_G.CommunitiesFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrameTab3.backdrop.shadow)
							end
							if _G.CommunitiesFrameTab4 and _G.CommunitiesFrameTab4.backdrop and not _G.CommunitiesFrameTab4.backdrop.shadow then
								_G.CommunitiesFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrameTab4.backdrop.shadow)
							end
							if _G.CommunitiesFrameTab5 and _G.CommunitiesFrameTab5.backdrop and not _G.CommunitiesFrameTab5.backdrop.shadow then
								_G.CommunitiesFrameTab5.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrameTab5.backdrop.shadow)
							end
							if _G.CommunitiesFrame.ChatTab and _G.CommunitiesFrame.ChatTab.backdrop and not _G.CommunitiesFrame.ChatTab.backdrop.shadow then
								_G.CommunitiesFrame.ChatTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.ChatTab.backdrop.shadow)
							end
							if _G.CommunitiesFrame.RosterTab and _G.CommunitiesFrame.RosterTab.backdrop and not _G.CommunitiesFrame.RosterTab.backdrop.shadow then
								_G.CommunitiesFrame.RosterTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.RosterTab.backdrop.shadow)
							end
							if _G.CommunitiesFrame.GuildBenefitsTab and _G.CommunitiesFrame.GuildBenefitsTab.backdrop and not _G.CommunitiesFrame.GuildBenefitsTab.backdrop.shadow then
								_G.CommunitiesFrame.GuildBenefitsTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.GuildBenefitsTab.backdrop.shadow)
							end
							if _G.CommunitiesFrame.GuildInfoTab and _G.CommunitiesFrame.GuildInfoTab.backdrop and not _G.CommunitiesFrame.GuildInfoTab.backdrop.shadow then
								_G.CommunitiesFrame.GuildInfoTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.GuildInfoTab.backdrop.shadow)
							end
							if _G.CommunitiesFrame.GuildMemberDetailFrame and not _G.CommunitiesFrame.GuildMemberDetailFrame.shadow then
								_G.CommunitiesFrame.GuildMemberDetailFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.GuildMemberDetailFrame.shadow)
							end
							if _G.ClubFinderGuildFinderFrame then
								if _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab and _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop and not _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow then
									_G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow)
								end
								if _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab and _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop and not _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow then
									_G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow)
								end
							end
							if _G.CommunitiesFrame.RecruitmentDialog and not _G.CommunitiesFrame.RecruitmentDialog.shadow then
								_G.CommunitiesFrame.RecruitmentDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CommunitiesFrame.RecruitmentDialog.shadow)
							end
							if _G.ClubFinderCommunityAndGuildFinderFrame then
								if _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab and _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop and not _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow then
									_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow)
								end
								if _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab and _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop and not _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow then
									_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow)
								end
							end
						end
					end
					if (arg == "Blizzard_GuildControlUI") or IsAddOnLoaded("Blizzard_GuildControlUI") then
						if _G.CommunitiesGuildLogFrame and not _G.CommunitiesGuildLogFrame.shadow then
							_G.CommunitiesGuildLogFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CommunitiesGuildLogFrame.shadow)
						end
						if _G.GuildControlUI and not _G.GuildControlUI.shadow then
							_G.GuildControlUI:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.GuildControlUI.shadow)
						end
					end
					if (arg == "Blizzard_AchievementUI") or IsAddOnLoaded("Blizzard_AchievementUI") then
						if E.Retail or E.Cata then
							if _G.AchievementFrame then
								if _G.AchievementFrame.backdrop then
									if not _G.AchievementFrame.backdrop.shadow then
										_G.AchievementFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.AchievementFrame.backdrop.shadow)
									end
								else
									if not _G.AchievementFrame.shadow then
										_G.AchievementFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G.AchievementFrame.shadow)
									end
								end
								if _G.AchievementFrame.SearchPreviewContainer and _G.AchievementFrame.SearchPreviewContainer.backdrop and not _G.AchievementFrame.SearchPreviewContainer.backdrop.shadow then
									 _G.AchievementFrame.SearchPreviewContainer.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.AchievementFrame.SearchPreviewContainer.backdrop.shadow)
								end
								if _G.AchievementFrame.SearchResults and _G.AchievementFrame.SearchResults.backdrop and not _G.AchievementFrame.SearchResults.backdrop.shadow then
									_G.AchievementFrame.SearchResults.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(_G.AchievementFrame.SearchResults.backdrop.shadow)
								end
							end
							if _G.AchievementFrameTab3 and _G.AchievementFrameTab3.backdrop and not _G.AchievementFrameTab3.backdrop.shadow then
								_G.AchievementFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AchievementFrameTab3.backdrop.shadow)
							end
						else
							if _G.AchievementFrame and _G.AchievementFrame.backdrop and not _G.AchievementFrame.backdrop.shadow then
								_G.AchievementFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AchievementFrame.backdrop.shadow)
							end
						end
						if _G.AchievementFrameTab1 and _G.AchievementFrameTab1.backdrop and not _G.AchievementFrameTab1.backdrop.shadow then
							_G.AchievementFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AchievementFrameTab1.backdrop.shadow)
						end
						if _G.AchievementFrameTab2 and _G.AchievementFrameTab2.backdrop and not _G.AchievementFrameTab2.backdrop.shadow then
							_G.AchievementFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AchievementFrameTab2.backdrop.shadow)
						end
					end
					if (arg == "Blizzard_GarrisonUI") or IsAddOnLoaded("Blizzard_GarrisonUI") then
						if _G.GarrisonLandingPage then
							if not _G.GarrisonLandingPage.shadow then
								_G.GarrisonLandingPage:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.GarrisonLandingPage.shadow)
							end
						end
						if  _G.GarrisonLandingPageTab1 and not _G.GarrisonLandingPageTab1.shadow then
							_G.GarrisonLandingPageTab1:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.GarrisonLandingPageTab1.shadow)
						end
						if _G.CovenantMissionFrame then
							if not _G.CovenantMissionFrame.shadow then
								_G.CovenantMissionFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CovenantMissionFrame.shadow)
							end
							if _G.CovenantMissionFrameTab1.backdrop and not _G.CovenantMissionFrameTab1.backdrop.shadow then
								_G.CovenantMissionFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CovenantMissionFrameTab1.backdrop.shadow)
							end
							if _G.CovenantMissionFrameTab2.backdrop and not _G.CovenantMissionFrameTab2.backdrop.shadow then
								_G.CovenantMissionFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CovenantMissionFrameTab2.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_CovenantSanctum") or IsAddOnLoaded("Blizzard_CovenantSanctum") then
						if _G.CovenantSanctumFrame then
							if not _G.CovenantSanctumFrame.shadow then
								_G.CovenantSanctumFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.CovenantSanctumFrame.shadow)
							end
						end
					end
					if (arg == "Blizzard_Soulbinds") or IsAddOnLoaded("Blizzard_Soulbinds") then
						if _G.SoulbindViewer then
							if not _G.SoulbindViewer.shadow then
								_G.SoulbindViewer:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.SoulbindViewer.shadow)
							end
						end
					end
					if (arg == "Blizzard_Collections") or IsAddOnLoaded("Blizzard_Collections") then
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournal.shadow)
						end
						if _G.CollectionsJournalTab1 and _G.CollectionsJournalTab1.backdrop and not _G.CollectionsJournalTab1.backdrop.shadow then
							_G.CollectionsJournalTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournalTab1.backdrop.shadow)
						end
						if _G.CollectionsJournalTab2 and _G.CollectionsJournalTab2.backdrop and not _G.CollectionsJournalTab2.backdrop.shadow then
							_G.CollectionsJournalTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournalTab2.backdrop.shadow)
						end
						if _G.CollectionsJournalTab3 and _G.CollectionsJournalTab3.backdrop and not _G.CollectionsJournalTab3.backdrop.shadow then
							_G.CollectionsJournalTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournalTab3.backdrop.shadow)
						end
						if _G.CollectionsJournalTab4 and _G.CollectionsJournalTab4.backdrop and not _G.CollectionsJournalTab4.backdrop.shadow then
							_G.CollectionsJournalTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournalTab4.backdrop.shadow)
						end
						if _G.CollectionsJournalTab5 and _G.CollectionsJournalTab5.backdrop and not _G.CollectionsJournalTab5.backdrop.shadow then
							_G.CollectionsJournalTab5.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.CollectionsJournalTab5.backdrop.shadow)
						end
						if not _G.ToyBox.shadow then
							_G.ToyBox:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ToyBox.shadow)
						end
						if not _G.HeirloomsJournal.shadow then
							_G.HeirloomsJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.HeirloomsJournal.shadow)
						end
						if not _G.PetJournal.shadow then
							_G.PetJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.PetJournal.shadow)
						end
						if _G.WardrobeFrame and not _G.WardrobeFrame.shadow then
							_G.WardrobeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.WardrobeFrame.shadow)
						end
					end
					if (arg == "Blizzard_ReforgingUI") or IsAddOnLoaded("Blizzard_ReforgingUI") then
						if not _G.ReforgingFrame.shadow then
							_G.ReforgingFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ReforgingFrame.shadow)
						end
					end
					if (arg == "Blizzard_PlayerChoice") or IsAddOnLoaded("Blizzard_PlayerChoice") then
						if not _G.PlayerChoiceFrame.shadow then
							_G.PlayerChoiceFrame:CreateBackdrop('Transparent')
							_G.PlayerChoiceFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.PlayerChoiceFrame.shadow)
						end
					end
					if (arg == "Blizzard_VoidStorageUI") or IsAddOnLoaded("Blizzard_VoidStorageUI") then
						if _G.VoidStorageFrame then
							if not _G.VoidStorageFrame.shadow then
								_G.VoidStorageFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.VoidStorageFrame.shadow)
							end
							if _G.VoidStorageFrame.Page1 and not _G.VoidStorageFrame.Page1.shadow then
								_G.VoidStorageFrame.Page1:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.VoidStorageFrame.Page1.shadow)
							end
							if _G.VoidStorageFrame.Page2 and not _G.VoidStorageFrame.Page2.shadow then
								_G.VoidStorageFrame.Page2:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.VoidStorageFrame.Page2.shadow)
							end
						end
					end
					if (arg == "Blizzard_ChallengesUI") or IsAddOnLoaded("Blizzard_ChallengesUI") then
						if not _G.PVEFrame.shadow then
							_G.PVEFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.PVEFrame.shadow)
						end
						if not _G.ChallengesKeystoneFrame.shadow then
							_G.ChallengesKeystoneFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ChallengesKeystoneFrame.shadow)
						end
					end
					if (arg == "Blizzard_Professions") or IsAddOnLoaded("Blizzard_Professions") then
						if _G.ProfessionsFrame and not _G.ProfessionsFrame.shadow then
							_G.ProfessionsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.ProfessionsFrame.shadow)
						end
						if _G.ProfessionsFrame and _G.ProfessionsFrame.TabSystem then
							for i = 1, _G.ProfessionsFrame.TabSystem:GetNumChildren() do
								local tab = select(i, _G.ProfessionsFrame.TabSystem:GetChildren())
								if tab and tab.backdrop then
									tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(tab.backdrop.shadow)
								end
							end
							if _G.ProfessionsFrame.CraftingPage.CraftingOutputLog then
								_G.ProfessionsFrame.CraftingPage.CraftingOutputLog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.ProfessionsFrame.CraftingPage.CraftingOutputLog.shadow)
							end
						end
					end
					if (arg == "Blizzard_EncounterJournal") or IsAddOnLoaded("Blizzard_EncounterJournal") then

						--fix the overflow button
						if _G.EncounterJournalNavBarOverflowButton and not _G.EncounterJournalNavBarOverflowButton.EltruismSkin then
							local S = E:GetModule('Skins')
							S:HandleButton(_G.EncounterJournalNavBarOverflowButton)
							_G.EncounterJournalNavBarOverflowButton.EltruismSkin = true
							_G.EncounterJournalNavBarOverflowButton.EltruismArrow = _G.EncounterJournalNavBarOverflowButton:CreateTexture()
							_G.EncounterJournalNavBarOverflowButton.EltruismArrow:SetTexture(E.Media.Textures.ArrowUp)
							_G.EncounterJournalNavBarOverflowButton.EltruismArrow:SetRotation(1.57)
							_G.EncounterJournalNavBarOverflowButton.EltruismArrow:SetScale(0.7)
							_G.EncounterJournalNavBarOverflowButton.EltruismArrow:SetPoint("CENTER", _G.EncounterJournalNavBarOverflowButton, "CENTER", 0, 0)
						end
						if not _G.EncounterJournal.shadow then
							_G.EncounterJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournal.shadow)
						end
						if _G.EncounterJournalSuggestTab and _G.EncounterJournalSuggestTab.backdrop and not _G.EncounterJournalSuggestTab.backdrop.shadow then
							_G.EncounterJournalSuggestTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalSuggestTab.backdrop.shadow)
						end
						if _G.EncounterJournalDungeonTab and _G.EncounterJournalDungeonTab.backdrop and not _G.EncounterJournalDungeonTab.backdrop.shadow then
							_G.EncounterJournalDungeonTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalDungeonTab.backdrop.shadow)
						end
						if _G.EncounterJournalRaidTab and _G.EncounterJournalRaidTab.backdrop and not _G.EncounterJournalRaidTab.backdrop.shadow then
							_G.EncounterJournalRaidTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalRaidTab.backdrop.shadow)
						end
						if _G.EncounterJournalLootJournalTab and _G.EncounterJournalLootJournalTab.backdrop and not _G.EncounterJournalLootJournalTab.backdrop.shadow then
							_G.EncounterJournalLootJournalTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalLootJournalTab.backdrop.shadow)
						end
						if _G.EncounterJournalEncounterFrameInfoOverviewTab and _G.EncounterJournalEncounterFrameInfoOverviewTab.backdrop and not _G.EncounterJournalEncounterFrameInfoOverviewTab.backdrop.shadow then
							_G.EncounterJournalEncounterFrameInfoOverviewTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalEncounterFrameInfoOverviewTab.backdrop.shadow)
						end
						if _G.EncounterJournalEncounterFrameInfoLootTab and _G.EncounterJournalEncounterFrameInfoLootTab.backdrop and not _G.EncounterJournalEncounterFrameInfoLootTab.backdrop.shadow then
							_G.EncounterJournalEncounterFrameInfoLootTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalEncounterFrameInfoLootTab.backdrop.shadow)
						end
						if _G.EncounterJournalEncounterFrameInfoBossTab and _G.EncounterJournalEncounterFrameInfoBossTab.backdrop and not _G.EncounterJournalEncounterFrameInfoBossTab.backdrop.shadow then
							_G.EncounterJournalEncounterFrameInfoBossTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalEncounterFrameInfoBossTab.backdrop.shadow)
						end
						if _G.EncounterJournalEncounterFrameInfoModelTab and _G.EncounterJournalEncounterFrameInfoModelTab.backdrop and not _G.EncounterJournalEncounterFrameInfoModelTab.backdrop.shadow then
							_G.EncounterJournalEncounterFrameInfoModelTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalEncounterFrameInfoModelTab.backdrop.shadow)
						end
						if _G.EncounterJournalMonthlyActivitiesTab and _G.EncounterJournalMonthlyActivitiesTab.backdrop and not _G.EncounterJournalMonthlyActivitiesTab.backdrop.shadow then
							_G.EncounterJournalMonthlyActivitiesTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.EncounterJournalMonthlyActivitiesTab.backdrop.shadow)
						end
					end
					if (arg == "Blizzard_WeeklyRewards") or IsAddOnLoaded("Blizzard_WeeklyRewards") then
						if not _G.WeeklyRewardsFrame.shadow then
							_G.WeeklyRewardsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.WeeklyRewardsFrame.shadow)
						end
					end
					if (arg == "Blizzard_AuctionHouseUI") or IsAddOnLoaded("Blizzard_AuctionHouseUI") then
						if _G.AuctionHouseFrame then
							if _G.AuctionHouseFrame and not _G.AuctionHouseFrame.shadow then
								_G.AuctionHouseFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AuctionHouseFrame.shadow)
							end
							if _G.AuctionHouseFrameBuyTab.backdrop and not _G.AuctionHouseFrameBuyTab.backdrop.shadow then
								_G.AuctionHouseFrameBuyTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AuctionHouseFrameBuyTab.backdrop.shadow)
							end
							if _G.AuctionHouseFrameSellTab.backdrop and not _G.AuctionHouseFrameSellTab.backdrop.shadow then
								_G.AuctionHouseFrameSellTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AuctionHouseFrameSellTab.backdrop.shadow)
							end
							if _G.AuctionHouseFrameAuctionsTab.backdrop and not _G.AuctionHouseFrameAuctionsTab.backdrop.shadow then
								_G.AuctionHouseFrameAuctionsTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G.AuctionHouseFrameAuctionsTab.backdrop.shadow)
							end
						end
					end
					if (arg == "Blizzard_AuctionUI") or IsAddOnLoaded("Blizzard_AuctionUI") then
						if _G.AuctionFrame and _G.AuctionFrame.backdrop and not _G.AuctionFrame.backdrop.shadow then
							_G.AuctionFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AuctionFrame.backdrop.shadow)
						end
						if _G.AuctionFrameTab1 and _G.AuctionFrameTab1.backdrop and not _G.AuctionFrameTab1.backdrop.shadow then
							_G.AuctionFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AuctionFrameTab1.backdrop.shadow)
						end
						if _G.AuctionFrameTab2 and _G.AuctionFrameTab2.backdrop and not _G.AuctionFrameTab2.backdrop.shadow then
							_G.AuctionFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AuctionFrameTab2.backdrop.shadow)
						end
						if _G.AuctionFrameTab3 and _G.AuctionFrameTab3.backdrop and not _G.AuctionFrameTab3.backdrop.shadow then
							_G.AuctionFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G.AuctionFrameTab3.backdrop.shadow)
						end
					end
				end
			end)

			local blizzardframes = {
				--_G.LFGParentFrame,
				--_G.SplashFrame,
				_G.AddFriendFrame,
				_G.AddonCompartmentFrame,
				_G.AddonList,
				_G.AutoCompleteBox,
				_G.BNToastFrame,
				_G.BonusRollFrame,
				_G.ChannelFrame,
				_G.CharacterFrame,
				_G.CharacterFrameTab1,
				_G.CharacterFrameTab2,
				_G.CharacterFrameTab3,
				_G.CharacterFrameTab4,
				_G.CharacterFrameTab4, --only in classic though
				_G.CharacterFrameTab5, --only in classic though
				_G.ChatConfigFrame,
				_G.ChatFrame1EditBox,
				_G.CinematicFrameCloseDialog,
				_G.CliqueSpellTab,
				_G.CollectionsJournal,
				_G.ColorPickerFrame,
				_G.CopyChatFrame,
				_G.CovenantPreviewFrame,
				_G.DressUpFrame,
				_G.DressUpFrame and _G.DressUpFrame.OutfitDetailsPanel,
				_G.DressUpFrame and _G.DressUpFrame.SetSelectionPanel,
				_G.DropDownList1,
				_G.DropDownList2,
				E.Retail and _G.EditModeManagerFrame,
				_G.EltruismClickCastingToggle,
				_G.EmbeddedItemTooltip,
				_G.EquipmentFlyoutFrameButtons,
				_G.ExpansionLandingPage and _G.ExpansionLandingPage.Overlay and _G.ExpansionLandingPage.Overlay.WarWithinLandingOverlay,
				_G.ExpansionLandingPage and _G.ExpansionLandingPage.Overlay and _G.ExpansionLandingPage.Overlay.DragonflightLandingOverlay,
				_G.ExtraActionButton1,
				_G.ExtraActionButton2,
				_G.ExtraActionButton3,
				_G.FriendsFrame,
				_G.FriendsFrameTab1,
				_G.FriendsFrameTab2,
				_G.FriendsFrameTab3,
				_G.FriendsFrameTab4,
				_G.FriendsFrameTab5, --only in classic though
				_G.FriendsTooltip,
				_G.GhostFrameContentsFrame,
				_G.GossipFrame,
				--_G.GroupFinderFrame,
				_G.GroupLootHistoryFrame,
				_G.GroupLootHistoryFrame and _G.GroupLootHistoryFrame.ResizeButton,
				_G.GuildInfoFrame,
				_G.HelpFrame,
				_G.InterfaceOptionsFrame,
				_G.ItemRefShoppingTooltip1,
				_G.ItemRefShoppingTooltip2,
				_G.ItemRefTooltip,
				_G.ItemTextFrame,
				_G.LFDReadyCheckPopup,
				_G.LFDRoleCheckPopup,
				_G.LFGBrowseFrame,
				_G.LFGDungeonReadyDialog and _G.LFGDungeonReadyDialog.Border,
				_G.LFGDungeonReadyStatus,
				_G.LFGInvitePopup,
				_G.LFGListApplicationDialog,
				_G.LFGListCreateRoleDialog,
				_G.LFGListingFrame,
				_G.LFGListInviteDialog,
				_G.LFGParentFrameTab1,
				_G.LFGParentFrameTab2,
				_G.LootFrame,
				_G.LootHistoryFrame and _G.LootHistoryFrame.ResizeButton,
				_G.LossOfControlFrame,
				_G.MailFrame,
				_G.MailFrameTab1,
				_G.MailFrameTab2,
				_G.MajorFactionRenownFrame,
				_G.MerchantFrame,
				_G.MerchantFrameTab1,
				_G.MerchantFrameTab2,
				_G.MinimapRightClickMenu,
				_G.MirrorTimer1StatusBar,
				_G.MirrorTimer2StatusBar,
				_G.MirrorTimer3StatusBar,
				_G.MovieFrame and _G.MovieFrame.CloseDialog,
				_G.OpacityFrame,
				_G.OpenMailFrame,
				_G.OrderHallCommandBar,
				_G.OrderHallMissionFrame,
				--_G.PaperDollFrame,
				_G.PetStableFrame,
				_G.ProfessionsFrame,
				_G.PVEFrame,
				_G.PVEFrameTab1,
				_G.PVEFrameTab2,
				_G.PVEFrameTab3,
				_G.PVEFrameTab4,
				_G.PVPFrame,
				_G.PVPFrameTab1,
				_G.PVPFrameTab2,
				_G.PVPFrameTab3,
				_G.PVPMatchResults,
				_G.PVPMatchScoreboard,
				_G.PVPParentFrameTab1,
				_G.PVPParentFrameTab2,
				_G.PVPReadyDialog,
				_G.QuestFrame,
				_G.QuestLogDetailFrame,
				_G.QuestLogFrame,
				_G.QuestModelScene,
				_G.QuestModelScene and _G.QuestModelScene.ModelTextFrame,
				_G.QuestNPCModelTextFrame,
				_G.QueueStatusFrame,
				_G.QuickKeybindTooltip,
				_G.RaidInfoFrame,
				_G.RaidUtilityPanel,
				_G.RaidUtility_CloseButton,
				_G.RaidUtility_ShowButton,
				_G.RaidUtilityTargetIcons,
				_G.RaidUtilityRoleIcons,
				_G.ReadyCheckFrame,
				_G.ReadyStatus,
				_G.RecruitAFriendRecruitmentFrame,
				_G.RecruitAFriendRewardsFrame,
				_G.ReportFrame,
				--_G.ReputationFrame,
				_G.ReputationDetailFrame,
				_G.ReputationParagonTooltip,
				_G.RolePollPopup,
				_G.SettingsPanel,
				_G.ShoppingTooltip1,
				_G.ShoppingTooltip2,
				_G.SpellBookFrame,
				_G.SpellBookFrameTabButton1,
				_G.SpellBookFrameTabButton2,
				_G.SpellBookFrameTabButton3,
				_G.SpellBookSkillLineTab1,
				_G.SpellBookSkillLineTab2,
				_G.SpellBookSkillLineTab3,
				_G.SpellBookSkillLineTab4,
				_G.SpellBookSkillLineTab5,
				_G.StableFrame,
				_G.StackSplitFrame,
				_G.StaticPopup1, --seems like blizzard
				_G.StaticPopup2, --seems like blizzard
				_G.StaticPopup3, --seems like blizzard
				_G.StaticPopup4, --seems like blizzard
				_G.StaticPopup5, --seems like blizzard
				_G.StopwatchFrame,
				_G.SubscriptionInterstitialFrame,
				_G.TabardFrame,
				_G.TaxiFrame,
				_G.TicketStatusFrameButton,
				_G.TimeAlertFrame,
				_G.TimeManagerFrame,
				_G.TimerTrackerTimer1StatusBar,
				_G.TimerTrackerTimer2StatusBar,
				_G.TimerTrackerTimer3StatusBar,
				--_G.TokenFrame,
				_G.TokenFramePopup,
				_G.TradeFrame,
				_G.VideoOptionsFrame,
				_G.VoidStorageFrame,
				_G.WardrobeFrame, --weird
				_G.WeeklyRewardsFrame,
				E.Retail and _G.WorldMapFrame,
				E.Retail and _G.WorldMapFrame and _G.QuestMapFrame and _G.QuestMapFrame.QuestsTab,
				E.Retail and _G.WorldMapFrame and _G.QuestMapFrame and _G.QuestMapFrame.MapLegendTab,
				not E.Retail and _G.WorldMapFrame and _G.WorldMapFrame.BorderFrame,
				not E.Retail and _G.WorldMapFrame and _G.WorldMapFrame.MiniBorderFrame,
				_G.WorldMapTooltip,
				_G.WorldStateScoreFrame,
				_G.WorldStateScoreFrameTab1,
				_G.WorldStateScoreFrameTab2,
				_G.WorldStateScoreFrameTab3,
				_G.ZoneAbilityFrame,
				_G.GameMenuFrame,
				_G.DelvesCompanionConfigurationFrame,
				_G.DelvesCompanionAbilityListFrame,
				_G.GuildInviteFrame,
				_G.CurrencyTransferMenu,
			}
			for _, frame in pairs(blizzardframes) do
				if frame then
					if frame.backdrop then
						if not frame.backdrop.shadow then
							frame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.backdrop.shadow)
						end
					else
						if not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end
				end
			end

			timermonitor:RegisterEvent("START_TIMER")
			timermonitor:SetScript("OnEvent", function()
				if _G.TimerTracker and _G.TimerTracker.timerList then
					for _, b in pairs(_G.TimerTracker.timerList) do
						if b.bar and not b.bar.shadow then
							b.bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(b.bar.shadow)
						end
					end
				end
			end)

			hooksecurefunc(_G.AlertFrame, "AddAlertFrame", function(_,frame)
				if frame and frame.backdrop and not frame.backdrop.shadow then
					frame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(frame.backdrop.shadow)
				end
			end)

			--mirror timer shadow
			if E.Cata then
				hooksecurefunc('TimerTracker_StartTimerOfType', function() --from elvui
					for _, frame in pairs(_G.TimerTracker.timerList) do
						if frame and frame.bar and not frame.bar.shadow then
							frame.bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.bar.shadow)
						end
					end
				end)
			end

			if IsAddOnLoaded("Rarity") then --rarity loads these before
				local rarityalreadyloads = {
					_G.CollectionsJournalTab1.backdrop,
					_G.CollectionsJournalTab2.backdrop,
					_G.CollectionsJournalTab3.backdrop,
					_G.CollectionsJournalTab4.backdrop,
					_G.CollectionsJournalTab5.backdrop,
				}
				for _, frame in pairs(rarityalreadyloads) do
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end
		end
		------------------------------------------------------------------------------------------------------ minimap
		if E.private.general.minimap.enable and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) and E.db.ElvUI_EltreumUI.skins.shadow.minimap then

			local Minimapsizex, Minimapsizey = _G["Minimap"]:GetSize()
			MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
			MinimapShadow:SetParent(_G["Minimap"])
			if not (self.minimapIsSkinned) then
				MinimapShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"] ,"TOPRIGHT", 0, 0)
				MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", 0, 0)
				if not E.db.datatexts.panels.MinimapPanel.backdrop or not E.db.datatexts.panels.MinimapPanel.enable then
					MinimapShadow:SetPoint("BOTTOMLEFT", _G["Minimap"] ,"BOTTOMLEFT", 0, 0)
				end
				if IsAddOnLoaded("ElvUI_SLE") and E.private.sle.minimap.rectangle then --Shadow and Light Rectangle Minimap
					if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable then
						MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 0, 0)
						MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", 0, 0)
					elseif not E.db.datatexts.panels.MinimapPanel.backdrop or not E.db.datatexts.panels.MinimapPanel.enable then
						MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 0, 0)
						MinimapShadow:SetPoint("BOTTOMLEFT", _G["Minimap"].backdrop ,"BOTTOMLEFT", 0, 0)
					end
				elseif IsAddOnLoaded("ElvUI_WindTools") and E.db.WT.maps.rectangleMinimap.enable then --Windtools rectangle minimap
					MinimapShadow:SetAllPoints(_G["Minimap"].backdrop)
					if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable then
						if _G["MinimapPanel"] and not _G["MinimapPanel"].shadow then
							_G["MinimapPanel"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["MinimapPanel"].shadow)
						end
					end
				end
				MinimapShadow:Show()
				ElvUI_EltreumUI:ShadowColor(MinimapShadow.shadow)
				self.minimapIsSkinned = true
			end
		end
		------------------------------------------------------------------------------------------------------ tooltip
		if E.db.ElvUI_EltreumUI.skins.shadow.tooltip then
			if _G.GameTooltip and not _G.GameTooltip.shadow then
				if E.private.tooltip.enable then
					_G.GameTooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.GameTooltip.shadow)
				end
			end

			if _G.LibDBIconTooltip and not _G.LibDBIconTooltip.shadow then
				if E.private.tooltip.enable then
					_G.LibDBIconTooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.LibDBIconTooltip.shadow)
				end
			end

			--finally fix gametooltip shadow
			if _G.GameTooltipStatusBar and E.private.tooltip.enable then
				_G.GameTooltipStatusBar:HookScript("OnShow", function()
					if _G.GameTooltip.shadow then
						if E.db.tooltip.healthBar.statusPosition == "TOP" then
							_G.GameTooltip.shadow:ClearAllPoints()
							_G.GameTooltip.shadow:SetPoint("BOTTOMLEFT", _G.GameTooltip,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G.GameTooltip.shadow:SetPoint("BOTTOMRIGHT", _G.GameTooltip,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G.GameTooltip.shadow:SetPoint("TOPLEFT", _G.GameTooltip,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.tooltip.healthBar.height+E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G.GameTooltip.shadow:SetPoint("TOPRIGHT", _G.GameTooltip,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.tooltip.healthBar.height+E.db.ElvUI_EltreumUI.skins.shadow.length)
						elseif E.db.tooltip.healthBar.statusPosition == "BOTTOM" then
							_G.GameTooltip.shadow:ClearAllPoints()
							_G.GameTooltip.shadow:SetPoint("BOTTOMLEFT", _G.GameTooltip,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -(E.db.tooltip.healthBar.height+E.db.ElvUI_EltreumUI.skins.shadow.length))
							_G.GameTooltip.shadow:SetPoint("BOTTOMRIGHT", _G.GameTooltip,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -(E.db.tooltip.healthBar.height+E.db.ElvUI_EltreumUI.skins.shadow.length))
							_G.GameTooltip.shadow:SetPoint("TOPLEFT", _G.GameTooltip,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G.GameTooltip.shadow:SetPoint("TOPRIGHT", _G.GameTooltip,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						ElvUI_EltreumUI:ShadowColor(_G.GameTooltip.shadow)
					end
				end)
				_G.GameTooltipStatusBar:HookScript("OnHide", function()
					if _G.GameTooltip.shadow then
						_G.GameTooltip.shadow:ClearAllPoints()
						_G.GameTooltip.shadow:SetPoint("BOTTOMLEFT", _G.GameTooltip,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G.GameTooltip.shadow:SetPoint("BOTTOMRIGHT", _G.GameTooltip,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G.GameTooltip.shadow:SetPoint("TOPLEFT", _G.GameTooltip,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G.GameTooltip.shadow:SetPoint("TOPRIGHT", _G.GameTooltip,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					ElvUI_EltreumUI:ShadowColor(_G.GameTooltip.shadow)
				end)
			end

			--datatexts
			if DT.tooltip then
				if not DT.tooltip.shadow then
					DT.tooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(DT.tooltip.shadow)
				end
			end
		end
		------------------------------------------------------------------------------------------------------version specific
		if E.Retail then
			if E.db.ElvUI_EltreumUI.skins.shadow.blizzard then --reputation detail got moved
				if _G.ReputationFrame and _G.ReputationFrame.ReputationDetailFrame then
					_G.ReputationFrame.ReputationDetailFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.ReputationFrame.ReputationDetailFrame.shadow)
				end
				if _G.DelvesCompanionConfigurationFrame and _G.DelvesCompanionConfigurationFrame.CompanionPortraitFrame then --fix shadow overlap
					_G.DelvesCompanionConfigurationFrame.CompanionPortraitFrame:SetFrameLevel(20)
				end
			end
		end

		if E.Retail or E.Cata then
			if E.db.ElvUI_EltreumUI.skins.shadow.blizzard then

				--loss of control frame icon
				if _G.LossOfControlFrame and _G.LossOfControlFrame.Icon and _G.LossOfControlFrame.shadow then
					_G.LossOfControlFrame.shadow:ClearAllPoints()
					_G.LossOfControlFrame.shadow:SetPoint("TOPLEFT", _G.LossOfControlFrame.Icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G.LossOfControlFrame.shadow:SetPoint("BOTTOMRIGHT", _G.LossOfControlFrame.Icon, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.LossOfControlFrame.shadow)
				end

				--main minimize button easier here
				if _G.ObjectiveTrackerFrame then
					if _G.ObjectiveTrackerFrame.HeaderMenu and _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton and not _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow then
						_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:CreateShadow()
						_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:ClearAllPoints()
						_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.tex, "TOPLEFT", -2,2)
						_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
						ElvUI_EltreumUI:ShadowColor(_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow)
					end
					if _G.ObjectiveTrackerFrame.Header and _G.ObjectiveTrackerFrame.Header.MinimizeButton and not _G.ObjectiveTrackerFrame.Header.MinimizeButton.shadow then
						_G.ObjectiveTrackerFrame.Header.MinimizeButton:CreateShadow()
						_G.ObjectiveTrackerFrame.Header.MinimizeButton.shadow:ClearAllPoints()
						_G.ObjectiveTrackerFrame.Header.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerFrame.Header.MinimizeButton.tex, "TOPLEFT", -2,2)
						_G.ObjectiveTrackerFrame.Header.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerFrame.Header.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
						ElvUI_EltreumUI:ShadowColor(_G.ObjectiveTrackerFrame.Header.MinimizeButton.shadow)
					end
				end

				if E.db.ElvUI_EltreumUI.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then
					if _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ProfessionHeader and _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton and not _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow then
						_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton:CreateShadow()
						_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:ClearAllPoints()
						_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.tex, "TOPLEFT", -2,2)
						_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
						ElvUI_EltreumUI:ShadowColor(_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow)
					end
				end
			end
		end
		------------------------------------------------------------------------------------------------------elvui frames
		if E.db.ElvUI_EltreumUI.skins.shadow.blizzard then --enable with blizzard due to the elvui skin
			local GeneralElvUIFrames = {
				_G["ElvLootFrame"],
				_G["ElvUI_ReputationBar"],
				_G["ElvUI_ExperienceBar"],
				_G["ElvUI_ThreatBar"],
				_G["ElvUIVendorGraysFrame"],
				_G["ElvUI_ContainerFrameContainerHolder"],
				_G["ElvUI_AltPowerBar"],
				_G["ElvUISpellBookTooltip"],
				_G["ElvUIConfigTooltip"],
				_G["ElvUIAceConfigDialogTooltip"],
				E.ConfigTooltip,
				E.SpellBookTooltip,
				_G["ElvUIPetBattleActionBar"],
				_G["ElvUI_TopPanel"],
				_G["ElvUI_BottomPanel"],
			}
			for _, frame in pairs(GeneralElvUIFrames) do
				if frame and not frame.shadow then
					frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(frame.shadow)
				end
			end

			--elvui popup
			for i = 1, 5 do
				local ElvUI_StaticPopups = {_G["ElvUI_StaticPopup"..i]}
				for _, button in pairs(ElvUI_StaticPopups) do
					if not button.shadow then
						button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(button.shadow)
					end
				end
			end

			--elvui bag bar
			if _G["ElvUIBagBar"] then
				if _G["ElvUIBagBar"].backdrop and _G["ElvUIBagBar"].backdrop:IsShown() then
					if not _G["ElvUIBagBar"].backdrop.shadow then
						_G["ElvUIBagBar"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["ElvUIBagBar"].backdrop.shadow)
					end
				else
					if _G["KeyRingButton"] and not _G["KeyRingButton"].shadow then
						_G["KeyRingButton"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["KeyRingButton"].shadow)
					end
					if _G["MainMenuBarBackpackButton"] and not _G["MainMenuBarBackpackButton"].shadow then
						_G["MainMenuBarBackpackButton"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["MainMenuBarBackpackButton"].shadow)
					end
					for i = 0, 3 do
						if _G["CharacterBag"..i.."Slot"] and not _G["CharacterBag"..i.."Slot"].shadow then
							_G["CharacterBag"..i.."Slot"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["CharacterBag"..i.."Slot"].shadow)
						end
					end
				end
			end

			--elvui config shadows
			if E.private.skins.blizzard.enable then
				hooksecurefunc(E, "ToggleOptions", function()
					local frame = E:Config_GetWindow()
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end)
			end

			--statusreport
			hooksecurefunc(E, "ShowStatusReport", function()
				if _G["ElvUIStatusReport"] and not _G["ElvUIStatusReport"].shadow then
					_G["ElvUIStatusReport"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ElvUIStatusReport"].shadow)
				end
				if _G["ElvUIStatusPlugins"] and not _G["ElvUIStatusPlugins"].shadow then
					_G["ElvUIStatusPlugins"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ElvUIStatusPlugins"].shadow)
				end
			end)
		end
		------------------------------------------------------------------------------------------------------action bars
		if E.db.ElvUI_EltreumUI.skins.shadow.actionbars then

			--general action bars
			if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") and not IsAddOnLoaded("Masque") then
				--elvui action bars
				for i = 1, 15 do
					if E.db.actionbar["bar"..i] and E.db.actionbar["bar"..i].backdrop then
						if _G["ElvUI_Bar"..i] and _G["ElvUI_Bar"..i].backdrop then
							_G["ElvUI_Bar"..i].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUI_Bar"..i].backdrop.shadow)
						end
					else
						for k = 1, 12 do
							local slots = {_G["ElvUI_Bar"..i..'Button'..k]}
							for _, button in pairs(slots) do
								if button and not button.shadow and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders["bar"..i.."borders"]) then
									button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(button.shadow)
								end
							end
						end
					end
				end

				--pet bars
				if E.db.actionbar.barPet and E.db.actionbar.barPet.backdrop then
					if _G["ElvUI_BarPet"] and _G["ElvUI_BarPet"].backdrop then
						if not _G["ElvUI_BarPet"].backdrop.shadow then
							_G["ElvUI_BarPet"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUI_BarPet"].backdrop.shadow)
						end
					end
				else
					if not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.petactionborders) then
						for i = 1, 12 do
							local button = _G["PetActionButton"..i]
							if not button then
								break
							else
								if not button.shadow and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.petactionborders) then
									button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(button.shadow)
								end
							end
						end
					end
				end

				--stances
				if E.db.actionbar.stanceBar and E.db.actionbar.stanceBar.backdrop then
					if _G["ElvUI_StanceBar"] and _G["ElvUI_StanceBar"].backdrop then
						_G["ElvUI_StanceBar"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["ElvUI_StanceBar"].backdrop.shadow)
					end
				else
					if not _G["EltruismStanceBorder1"] and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.stanceborders) then
						for i = 1, 12 do
							local button = _G["ElvUI_StanceBarButton"..i]
							if not button then
								break
							else
								if not button.shadow then
									button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(button.shadow)
								end
							end
						end
					end
				end

				--boss
				if E.private.actionbar.enable and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
					if _G.BossButton and not _G.BossButton.shadow then
						_G.BossButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G.BossButton.shadow)
					end
				end
			end

			--class totems
			for i = 1, MAX_TOTEMS do
				local classtotem = _G['ElvUI_TotemTrackerTotem'..i]
				if classtotem and not classtotem.shadow then
					classtotem:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(classtotem.shadow)
				end
			end

			--microbar shadow
			if E.db.actionbar.microbar.enabled then
				if E.db.actionbar.microbar.backdrop then
					if _G.ElvUI_MicroBar and _G.ElvUI_MicroBar.backdrop and not _G.ElvUI_MicroBar.backdrop.shadow then
						_G.ElvUI_MicroBar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G.ElvUI_MicroBar.backdrop.shadow)
					end
				else
					local microbar = {
						_G["CharacterMicroButton"],
						_G["SpellbookMicroButton"],
						_G["TalentMicroButton"],
						_G["QuestLogMicroButton"],
						_G["SocialsMicroButton"],
						_G["MainMenuMicroButton"],
						_G["HelpMicroButton"],
						_G["LFGMicroButton"],
						_G["WorldMapMicroButton"],
						_G["AchievementMicroButton"],
						_G["GuildMicroButton"],
						_G["LFDMicroButton"],
						_G["EJMicroButton"],
						_G["CollectionsMicroButton"],
						_G["StoreMicroButton"],
					}
					for _, frame in pairs(microbar) do
						if frame and not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end
				end
			end

			--Shaman Totem things
			if E.Cata then
				if E.myclass == "SHAMAN" and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.totembar) and E.db.actionbar.totemBar.enable then
					local totemframes = {
						_G.MultiCastSummonSpellButton,
						_G.MultiCastRecallSpellButton,
						_G.MultiCastActionButton1,
						_G.MultiCastActionButton2,
						_G.MultiCastActionButton3,
						_G.MultiCastActionButton4,
						_G.MultiCastFlyoutFrameCloseButton.backdrop,
						_G.MultiCastFlyoutFrameOpenButton.backdrop,
					}
					for _, frame in pairs(totemframes) do
						if frame and not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end

					hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout", function()
						local Flyframes = {
							_G.MultiCastFlyoutButton1,
							_G.MultiCastFlyoutButton2,
							_G.MultiCastFlyoutButton3,
							_G.MultiCastFlyoutButton4,
							_G.MultiCastFlyoutButton5,
							_G.MultiCastFlyoutButton6,
							_G.MultiCastFlyoutButton7,
						}
						for _, frame in pairs(Flyframes) do
							if frame and not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end)
				end
			end
		end
		------------------------------------------------------------------------------------------------------unitframes
		if E.db.ElvUI_EltreumUI.skins.shadow.unitframes then
			if E.private.unitframe.enable then

				if E.db.ElvUI_EltreumUI.borders.borders then
					if _G["ElvUF_Player_HealthBar"] then
						if not E.db.ElvUI_EltreumUI.borders.playerborder then
							if not _G["ElvUF_Player_HealthBar"].shadow then
								_G["ElvUF_Player_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_HealthBar"].shadow)
							end
						else
							if _G["ElvUF_Player_HealthBar"].shadow then
								_G["ElvUF_Player_HealthBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Player_PowerBar"] then
						if not E.db.ElvUI_EltreumUI.borders.playerpower then
							if not _G["ElvUF_Player_PowerBar"].shadow then
								_G["ElvUF_Player_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_PowerBar"].shadow)
							end
						else
							if _G["ElvUF_Player_PowerBar"].shadow then
								_G["ElvUF_Player_PowerBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Pet_HealthBar"] then
						if not E.db.ElvUI_EltreumUI.borders.petborder then
							if not _G["ElvUF_Pet_HealthBar"].shadow then
								_G["ElvUF_Pet_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Pet_HealthBar"].shadow)
							end
						else
							if _G["ElvUF_Pet_HealthBar"].shadow then
								_G["ElvUF_Pet_HealthBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Pet_PowerBar"] then
						if not E.db.ElvUI_EltreumUI.borders.petpower then
							if not _G["ElvUF_Pet_PowerBar"].shadow then
								_G["ElvUF_Pet_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Pet_PowerBar"].shadow)
							end
						else
							if _G["ElvUF_Pet_PowerBar"].shadow then
								_G["ElvUF_Pet_PowerBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Target_HealthBar"] then
						if not E.db.ElvUI_EltreumUI.borders.targetborder then
							if not _G["ElvUF_Target_HealthBar"].shadow then
								_G["ElvUF_Target_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_HealthBar"].shadow)
							end
						else
							if _G["ElvUF_Target_HealthBar"].shadow then
								_G["ElvUF_Target_HealthBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Target_PowerBar"] then
						if not E.db.ElvUI_EltreumUI.borders.targetpower then
							if not _G["ElvUF_Target_PowerBar"].shadow then
								_G["ElvUF_Target_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_PowerBar"].shadow)
							end
						else
							if _G["ElvUF_Target_PowerBar"].shadow then
								_G["ElvUF_Target_PowerBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_TargetTarget_HealthBar"] then
						if not E.db.ElvUI_EltreumUI.borders.targettargetborder then
							if not _G["ElvUF_TargetTarget_HealthBar"].shadow then
								_G["ElvUF_TargetTarget_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget_HealthBar"].shadow)
							end
						else
							if _G["ElvUF_TargetTarget_HealthBar"].shadow then
								_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_TargetTarget_PowerBar"] then
						if not E.db.ElvUI_EltreumUI.borders.targettargetpower then
							if not _G["ElvUF_TargetTarget_PowerBar"].shadow then
								_G["ElvUF_TargetTarget_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget_PowerBar"].shadow)
							end
						else
							if _G["ElvUF_TargetTarget_PowerBar"].shadow then
								_G["ElvUF_TargetTarget_PowerBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Focus_HealthBar"] then
						if not E.db.ElvUI_EltreumUI.borders.focusborder then
							if not _G["ElvUF_Focus_HealthBar"].shadow then
								_G["ElvUF_Focus_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_HealthBar"].shadow)
							end
						else
							if _G["ElvUF_Focus_HealthBar"].shadow then
								_G["ElvUF_Focus_HealthBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Focus_PowerBar"] then
						if not E.db.ElvUI_EltreumUI.borders.focuspower then
							if not _G["ElvUF_Focus_PowerBar"].shadow then
								_G["ElvUF_Focus_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_PowerBar"].shadow)
							end
						else
							if _G["ElvUF_Focus_PowerBar"].shadow then
								_G["ElvUF_Focus_PowerBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Player_Stagger"] then
						if not E.db.ElvUI_EltreumUI.borders.staggerclassbar then
							if not _G["ElvUF_Player_Stagger"].shadow then
								_G["ElvUF_Player_Stagger"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_Stagger"].shadow)
							end
						else
							if _G["ElvUF_Player_Stagger"].shadow then
								_G["ElvUF_Player_Stagger"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Player_CastBar"] then
						if not E.db.ElvUI_EltreumUI.borders.playercastborder then
							if not _G["ElvUF_Player_CastBar"].shadow then
								_G["ElvUF_Player_CastBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].shadow)
							end
						else
							if _G["ElvUF_Player_CastBar"].shadow then
								_G["ElvUF_Player_CastBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Target_CastBar"] then
						if not E.db.ElvUI_EltreumUI.borders.targetcastborder then
							if not _G["ElvUF_Target_CastBar"].shadow then
								_G["ElvUF_Target_CastBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].shadow)
							end
						else
							if _G["ElvUF_Target_CastBar"].shadow then
								_G["ElvUF_Target_CastBar"].shadow:Hide()
							end
						end
					end
					if _G["ElvUF_Focus_CastBar"] then
						if not E.db.ElvUI_EltreumUI.borders.focuscastborder then
							if not _G["ElvUF_Focus_CastBar"].shadow then
								_G["ElvUF_Focus_CastBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].shadow)
							end
						else
							if _G["ElvUF_Focus_CastBar"].shadow then
								_G["ElvUF_Focus_CastBar"].shadow:Hide()
							end
						end
					end

					local shamantotems = {
						_G["ElvUF_PlayerTotem1"] and _G["ElvUF_PlayerTotem1"].backdrop,
						_G["ElvUF_PlayerTotem2"] and _G["ElvUF_PlayerTotem2"].backdrop,
						_G["ElvUF_PlayerTotem3"] and _G["ElvUF_PlayerTotem3"].backdrop,
						_G["ElvUF_PlayerTotem4"] and _G["ElvUF_PlayerTotem4"].backdrop,
					}
					for _, frame in pairs(shamantotems) do
						if frame then
							if not E.db.ElvUI_EltreumUI.borders.totembar then
								if not frame.shadow then
									frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(frame.shadow)
								end
							else
								if frame.shadow then
									frame.shadow:Hide()
								end
							end
						end
					end
				else
					local elvuiframes = {
						_G["ElvUF_TargetTarget_HealthBar"],
						_G["ElvUF_TargetTarget_PowerBar"],
						_G["ElvUF_TargetTargetTarget_HealthBar"],
						_G["ElvUF_TargetTargetTarget_PowerBar"],
						_G["ElvUF_Target_HealthBar"],
						_G["ElvUF_Target_PowerBar"],
						_G["ElvUF_Pet_HealthBar"],
						_G["ElvUF_Pet_PowerBar"],
						_G["ElvUF_Player_HealthBar"],
						_G["ElvUF_Player_PowerBar"],
						_G["ElvUF_Focus_HealthBar"],
						_G["ElvUF_Focus_PowerBar"],
						_G["ElvUF_FocusTarget_HealthBar"],
						_G["ElvUF_FocusTarget_PowerBar"],
						_G["ElvUF_Arena1"],
						_G["ElvUF_Arena2"],
						_G["ElvUF_Arena3"],
						_G["ElvUF_Arena4"],
						_G["ElvUF_Arena5"],
						_G["ElvUF_Player_Stagger"],
						_G["ElvUF_Player_CastBar"],
						_G["ElvUF_Target_CastBar"],
						_G["ElvUF_Focus_CastBar"],
						_G["ElvUF_Player_EclipsePowerBar"],
						_G["ElvUF_PlayerTotem1"] and _G["ElvUF_PlayerTotem1"].backdrop,
						_G["ElvUF_PlayerTotem2"] and _G["ElvUF_PlayerTotem2"].backdrop,
						_G["ElvUF_PlayerTotem3"] and _G["ElvUF_PlayerTotem3"].backdrop,
						_G["ElvUF_PlayerTotem4"] and _G["ElvUF_PlayerTotem4"].backdrop,
					}
					for _, frame in pairs(elvuiframes) do
						if frame then
							if not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end
				end

				if not E.Classic then

					--focus power
					if E.db.unitframe.units.focus.power.width ~= "spaced" and E.db.unitframe.units.focus.power.enable then
						if not E.db.unitframe.units.focus.power.detachFromFrame then
							if not (E.db.unitframe.units.focus.power.width == "offset" and E.db.unitframe.units.focus.power.offset > 0) then
								if _G["ElvUF_Focus_PowerBar"] and _G["ElvUF_Focus_PowerBar"].shadow then
									_G["ElvUF_Focus_PowerBar"].shadow:Hide()
								end
							end
							if _G["ElvUF_Focus_HealthBar"] and _G["ElvUF_Focus_HealthBar"].shadow then
								_G["ElvUF_Focus_HealthBar"].shadow:Hide()
							end
							if _G["ElvUF_Focus"] and not _G["ElvUF_Focus"].shadow then
								_G["ElvUF_Focus"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus"].shadow)
							end
							if E.db.unitframe.units.focus.portrait.enable and E.db.unitframe.units.focus.portrait.style ~= "3D" and not benikdettached then
								_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								if E.db.unitframe.units.focus.power.width == "inset" then
									if _G["ElvUF_Focus"] and _G["ElvUF_Focus"].shadow then
										_G["ElvUF_Focus"].shadow:ClearAllPoints()
										_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.focus.power.width == "fill" then
									if _G["ElvUF_Focus"] and _G["ElvUF_Focus"].shadow then
										_G["ElvUF_Focus"].shadow:ClearAllPoints()
										_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if E.db.unitframe.units.focus.power.offset == 0 then
										if _G["ElvUF_Focus"] and _G["ElvUF_Focus"].shadow then
											_G["ElvUF_Focus"].shadow:ClearAllPoints()
											_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if E.db.unitframe.units.focus.portrait.enable and not E.db.unitframe.units.focus.portrait.overlay then
												_G["ElvUF_Focus"].shadow:ClearAllPoints()
												if E.db.unitframe.units.focus.orientation == "RIGHT" then
													_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.focus.orientation == "LEFT" then
													_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									else
										if _G["ElvUF_Focus"] and _G["ElvUF_Focus"].shadow then
											_G["ElvUF_Focus"].shadow:ClearAllPoints()
											_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Focus_PowerBar"] and _G["ElvUF_Focus_PowerBar"].shadow then
												_G["ElvUF_Focus_PowerBar"].shadow:Show()
											end
											if E.db.unitframe.units.focus.portrait.enable and not E.db.unitframe.units.focus.portrait.overlay then
												_G["ElvUF_Focus"].shadow:ClearAllPoints()
												if E.db.unitframe.units.focus.orientation == "RIGHT" then
													_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.focus.orientation == "LEFT" then
													_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									end
								end
							end
						else
							if _G["ElvUF_Focus"] and not _G["ElvUF_Focus"].shadow then
								_G["ElvUF_Focus"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus"].shadow)
							end
							if _G["ElvUF_Focus_HealthBar"] and _G["ElvUF_Focus_HealthBar"].shadow then
								_G["ElvUF_Focus_HealthBar"].shadow:Hide()
							end
							if _G["ElvUF_Focus"] and _G["ElvUF_Focus"].shadow then
								_G["ElvUF_Focus"].shadow:ClearAllPoints()
								_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
					end

					--focus portrait
					if E.db.unitframe.units.focus.enable and E.db.unitframe.units.focus.portrait.enable and not E.db.unitframe.units.focus.portrait.overlay then
						if _G["ElvUF_Focus"] and not _G["ElvUF_Focus"].shadow then
							if not (E.db.ElvUI_EltreumUI.borders.focusborder and E.db.ElvUI_EltreumUI.borders.borders) then
								_G["ElvUF_Focus"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus"].shadow:ClearAllPoints()
								if E.db.unitframe.units.focus.orientation == "RIGHT" then
									_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focus.infoPanel.enable then
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.focus.orientation == "LEFT" then
									_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focus.infoPanel.enable then
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focus.infoPanel.enable then
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
								if _G["ElvUF_Focus_HealthBar"].shadow then
									_G["ElvUF_Focus_HealthBar"].shadow:Hide()
								end
								if E.db.unitframe.units.focus.power.width ~= "spaced" then
									if not (E.db.unitframe.units.focus.power.width == "offset" and E.db.unitframe.units.focus.power.offset > 0) then
										if _G["ElvUF_Focus_PowerBar"].shadow then
											_G["ElvUF_Focus_PowerBar"].shadow:Hide()
										end
									end
								end
								if E.Retail then
									if _G["ElvUF_Focus_Stagger"] and _G["ElvUF_Focus_Stagger"].shadow then
										_G["ElvUF_Focus_Stagger"].shadow:Hide()
									end
								end

								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus"].shadow)
							end
						end
					end

					--focustarget power
					if E.db.unitframe.units.focustarget.power.width ~= "spaced" and E.db.unitframe.units.focustarget.power.enable then
						if not E.db.unitframe.units.focustarget.power.detachFromFrame then
							if not (E.db.unitframe.units.focustarget.power.width == "offset" and E.db.unitframe.units.focustarget.power.offset > 0) then
								if _G["ElvUF_FocusTarget_PowerBar"] and _G["ElvUF_FocusTarget_PowerBar"].shadow then
									_G["ElvUF_FocusTarget_PowerBar"].shadow:Hide()
								end
							end
							if _G["ElvUF_FocusTarget_HealthBar"] and _G["ElvUF_FocusTarget_HealthBar"].shadow then
								_G["ElvUF_FocusTarget_HealthBar"].shadow:Hide()
							end
							if _G["ElvUF_FocusTarget"] and not _G["ElvUF_FocusTarget"].shadow then
								_G["ElvUF_FocusTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_FocusTarget"].shadow)
							end
							if E.db.unitframe.units.focustarget.portrait.enable and E.db.unitframe.units.focustarget.portrait.style ~= "3D" and not benikdettached then
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								if E.db.unitframe.units.focustarget.power.width == "inset" then
									if _G["ElvUF_FocusTarget"] and _G["ElvUF_FocusTarget"].shadow then
										_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
										_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT",_G["ElvUF_FocusTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.focustarget.power.width == "fill" then
									if _G["ElvUF_FocusTarget"] and _G["ElvUF_FocusTarget"].shadow then
										_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
										_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if E.db.unitframe.units.focustarget.power.offset == 0 then
										if _G["ElvUF_FocusTarget"] and _G["ElvUF_FocusTarget"].shadow then
											_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
											_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if E.db.unitframe.units.focustarget.portrait.enable and not E.db.unitframe.units.focustarget.portrait.overlay then
												_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
												if E.db.unitframe.units.focustarget.orientation == "RIGHT" then
													_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.focustarget.orientation == "LEFT" then
													_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									else
										if _G["ElvUF_FocusTarget"] and _G["ElvUF_FocusTarget"].shadow then
											_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
											_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_FocusTarget_PowerBar"] and _G["ElvUF_FocusTarget_PowerBar"].shadow then
												_G["ElvUF_FocusTarget_PowerBar"].shadow:Show()
											end
											if E.db.unitframe.units.focustarget.portrait.enable and not E.db.unitframe.units.focustarget.portrait.overlay then
												_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
												if E.db.unitframe.units.focustarget.orientation == "RIGHT" then
													_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.focustarget.orientation == "LEFT" then
													_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									end
								end
							end
						else
							if _G["ElvUF_FocusTarget"] and not _G["ElvUF_FocusTarget"].shadow then
								_G["ElvUF_FocusTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_FocusTarget"].shadow)
							end
							if _G["ElvUF_FocusTarget_HealthBar"] and _G["ElvUF_FocusTarget_HealthBar"].shadow then
								_G["ElvUF_FocusTarget_HealthBar"].shadow:Hide()
							end
							if _G["ElvUF_FocusTarget"] and _G["ElvUF_FocusTarget"].shadow then
								_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
								_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
					end

					--focustarget portrait
					if E.db.unitframe.units.focustarget.enable and E.db.unitframe.units.focustarget.portrait.enable and not E.db.unitframe.units.focustarget.portrait.overlay then
						if _G["ElvUF_FocusTarget"] and not _G["ElvUF_FocusTarget"].shadow then
							if not (E.db.ElvUI_EltreumUI.borders.focustargetborder and E.db.ElvUI_EltreumUI.borders.borders) then
								_G["ElvUF_FocusTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
								if E.db.unitframe.units.focustarget.orientation == "RIGHT" then
									_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focustarget.infoPanel.enable then
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.focustarget.orientation == "LEFT" then
									_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focustarget.infoPanel.enable then
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focustarget.infoPanel.enable then
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
								if _G["ElvUF_FocusTarget_HealthBar"].shadow then
									_G["ElvUF_FocusTarget_HealthBar"].shadow:Hide()
								end
								if E.db.unitframe.units.focustarget.power.width ~= "spaced" then
									if not (E.db.unitframe.units.focustarget.power.width == "offset" and E.db.unitframe.units.focustarget.power.offset > 0) then
										if _G["ElvUF_FocusTarget_PowerBar"].shadow then
											_G["ElvUF_FocusTarget_PowerBar"].shadow:Hide()
										end
									end
								end
								if E.Retail then
									if _G["ElvUF_FocusTarget_Stagger"] and _G["ElvUF_FocusTarget_Stagger"].shadow then
										_G["ElvUF_FocusTarget_Stagger"].shadow:Hide()
									end
								end

								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_FocusTarget"].shadow)
							end
						end
					end
				end

				--player portrait
				if E.db.unitframe.units.player.enable and E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
					if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
						if not (E.db.ElvUI_EltreumUI.borders.playerborder and E.db.ElvUI_EltreumUI.borders.borders) then
							_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							if E.db.unitframe.units.player.orientation == "RIGHT" then
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.player.infoPanel.enable then
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							elseif E.db.unitframe.units.player.orientation == "LEFT" then
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.player.infoPanel.enable then
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.player.infoPanel.enable then
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if _G["ElvUF_Player_HealthBar"].shadow then
								_G["ElvUF_Player_HealthBar"].shadow:Hide()
							end
							if E.db.unitframe.units.player.power.width ~= "spaced" then
								if not (E.db.unitframe.units.player.power.width == "offset" and E.db.unitframe.units.player.power.offset > 0) then
									if _G["ElvUF_Player_PowerBar"].shadow then
										_G["ElvUF_Player_PowerBar"].shadow:Hide()
									end
								end
							end
							if E.Retail then
								if _G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"].shadow then
									_G["ElvUF_Player_Stagger"].shadow:Hide()
								end
							end

							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player"].shadow)
						end
					end
				end

				--target portrait
				if E.db.unitframe.units.target.enable and E.db.unitframe.units.target.portrait.enable and not E.db.unitframe.units.target.portrait.overlay then
					if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
						if not (E.db.ElvUI_EltreumUI.borders.targetborder and E.db.ElvUI_EltreumUI.borders.borders) then
							_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target"].shadow:ClearAllPoints()
							if E.db.unitframe.units.target.orientation == "LEFT" then
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.target.infoPanel.enable then
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							elseif E.db.unitframe.units.target.orientation == "RIGHT" then
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.target.infoPanel.enable then
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.target.infoPanel.enable then
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if _G["ElvUF_Target_HealthBar"].shadow then
								_G["ElvUF_Target_HealthBar"].shadow:Hide()
							end
							if E.db.unitframe.units.target.power.width ~= "spaced" then
								if not (E.db.unitframe.units.target.power.width == "offset" and E.db.unitframe.units.target.power.offset > 0) then
									if _G["ElvUF_Target_PowerBar"].shadow then
										_G["ElvUF_Target_PowerBar"].shadow:Hide()
									end
								end
							end
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target"].shadow)
						end
					end
				end

				--targettarget portrait
				if E.db.unitframe.units.targettarget.enable and E.db.unitframe.units.targettarget.portrait.enable and not E.db.unitframe.units.targettarget.portrait.overlay then
					if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
						if not (E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.ElvUI_EltreumUI.borders.borders) then
							_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
							if E.db.unitframe.units.targettarget.orientation == "LEFT" then
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.targettarget.infoPanel.enable then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							elseif E.db.unitframe.units.targettarget.orientation == "RIGHT" then
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.targettarget.infoPanel.enable then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.targettarget.infoPanel.enable then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if _G["ElvUF_TargetTarget_HealthBar"].shadow then
								_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
							end
							if E.db.unitframe.units.targettarget.power.width ~= "spaced" then
								if not (E.db.unitframe.units.targettarget.power.width == "offset" and E.db.unitframe.units.targettarget.power.offset > 0) then
									if _G["ElvUF_TargetTarget_PowerBar"].shadow then
										_G["ElvUF_TargetTarget_PowerBar"].shadow:Hide()
									end
								end
							end
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
					end
				end

				--player castbar
				if E.db.unitframe.units.player.enable and E.db.unitframe.units.player.castbar.overlayOnFrame == "None" and not (E.db.ElvUI_EltreumUI.borders.playercastborder and E.db.ElvUI_EltreumUI.borders.borders) and E.db.unitframe.units.player.castbar.icon then
					if _G["ElvUF_Player_CastBar"].shadow then
						if not E.db.unitframe.units.player.castbar.iconAttached then
							if E.db.unitframe.units.player.castbar.iconPosition == "RIGHT" then
								if E.db.unitframe.units.player.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.player.castbar.height ~= E.db.unitframe.units.player.castbar.iconSize and E.db.unitframe.units.player.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Player_CastBar"].Holder.shadow then
											_G["ElvUF_Player_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].Holder.shadow)
											_G["ElvUF_Player_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Player_CastBar"])
										end
									else
										_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon.bg, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon.bg, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Player_CastBar"].Holder.shadow then
										_G["ElvUF_Player_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].Holder.shadow)
										_G["ElvUF_Player_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Player_CastBar"])
									end
								end
							else
								if E.db.unitframe.units.player.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.player.castbar.height ~= E.db.unitframe.units.player.castbar.iconSize and E.db.unitframe.units.player.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Player_CastBar"].Holder.shadow then
											_G["ElvUF_Player_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].Holder.shadow)
											_G["ElvUF_Player_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Player_CastBar"])
										end
									else
										_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Player_CastBar"].Holder.shadow then
										_G["ElvUF_Player_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].Holder.shadow)
										_G["ElvUF_Player_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Player_CastBar"])
									end
								end
							end
						elseif E.db.unitframe.units.player.castbar.iconAttached then
							if E.db.unitframe.units.player.orientation == "RIGHT" then
								_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
						ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_CastBar"].shadow)
					end
				end

				--target castbar
				if E.db.unitframe.units.target.enable and E.db.unitframe.units.target.castbar.overlayOnFrame == "None" and not (E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.ElvUI_EltreumUI.borders.borders) and E.db.unitframe.units.target.castbar.icon then
					if _G["ElvUF_Target_CastBar"].shadow then
						if not E.db.unitframe.units.target.castbar.iconAttached then
							if E.db.unitframe.units.target.castbar.iconPosition == "RIGHT" then
								if E.db.unitframe.units.target.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.target.castbar.height ~= E.db.unitframe.units.target.castbar.iconSize and E.db.unitframe.units.target.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Target_CastBar"].Holder.shadow then
											_G["ElvUF_Target_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].Holder.shadow)
											_G["ElvUF_Target_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Target_CastBar"])
										end
									else
										_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon.bg, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon.bg, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Target_CastBar"].Holder.shadow then
										_G["ElvUF_Target_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].Holder.shadow)
										_G["ElvUF_Target_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Target_CastBar"])
									end
								end
							else
								if E.db.unitframe.units.target.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.target.castbar.height ~= E.db.unitframe.units.target.castbar.iconSize and E.db.unitframe.units.target.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Target_CastBar"].Holder.shadow then
											_G["ElvUF_Target_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].Holder.shadow)
											_G["ElvUF_Target_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Target_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Target_CastBar"])
										end
									else
										_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Target_CastBar"].Holder.shadow then
										_G["ElvUF_Target_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].Holder.shadow)
										_G["ElvUF_Target_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Target_CastBar"])
									end
								end
							end
						elseif E.db.unitframe.units.target.castbar.iconAttached then
							if E.db.unitframe.units.target.orientation == "RIGHT" then
								_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
						ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_CastBar"].shadow)
					end
				end

				--focus castbar
				if E.db.unitframe.units.focus.enable and E.db.unitframe.units.focus.castbar.overlayOnFrame == "None" and E.db.unitframe.units.focus.castbar.icon and E.db.unitframe.units.focus.enable then
					if _G["ElvUF_Focus_CastBar"] and _G["ElvUF_Focus_CastBar"].shadow then
						if not E.db.unitframe.units.focus.castbar.iconAttached then
							if E.db.unitframe.units.focus.castbar.iconPosition == "RIGHT" then
								if E.db.unitframe.units.focus.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.focus.castbar.height ~= E.db.unitframe.units.focus.castbar.iconSize and E.db.unitframe.units.focus.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Focus_CastBar"].Holder.shadow then
											_G["ElvUF_Focus_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].Holder.shadow)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Focus_CastBar"])
										end
									else
										_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon.bg, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon.bg, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Focus_CastBar"].Holder.shadow then
										_G["ElvUF_Focus_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].Holder.shadow)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Focus_CastBar"])
									end
								end
							else
								if E.db.unitframe.units.focus.castbar.iconAttachedTo == "Castbar" then
									if E.db.unitframe.units.focus.castbar.height ~= E.db.unitframe.units.focus.castbar.iconSize and E.db.unitframe.units.focus.castbar.iconXOffset ~= 0 then
										if not _G["ElvUF_Focus_CastBar"].Holder.shadow then
											_G["ElvUF_Focus_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].Holder.shadow)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:ClearAllPoints()
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Focus_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Focus_CastBar"])
										end
									else
										_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if not _G["ElvUF_Focus_CastBar"].Holder.shadow then
										_G["ElvUF_Focus_CastBar"].Holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].Holder.shadow)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:ClearAllPoints()
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus_CastBar"].Holder.shadow:SetParent(_G["ElvUF_Focus_CastBar"])
									end
								end
							end
						elseif E.db.unitframe.units.focus.castbar.iconAttached then
							if E.db.unitframe.units.focus.orientation == "RIGHT" then
								_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
						ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus_CastBar"].shadow)
					end
				end

				--party
				for i = 1, 5 do
					local partymembers = {_G["ElvUF_PartyGroup1UnitButton"..i]}
					for _, frame in pairs(partymembers) do
						if not frame.shadow then
							if not (E.db.ElvUI_EltreumUI.borders.partyborders and E.db.ElvUI_EltreumUI.borders.borders) then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.party.power.enable then
									if E.db.unitframe.units.party.power.width == "spaced" then
										frame.shadow:ClearAllPoints()
										frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPLEFT", frame.Health,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPRIGHT", frame.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										if not frame.Power.shadow then
											frame.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
											ElvUI_EltreumUI:ShadowColor(frame.Power.shadow)
										end
									elseif E.db.unitframe.units.party.power.width == "offset" then
										if E.db.unitframe.units.player.power.offset >= 0 then
											if not frame.Power.shadow then
												frame.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												ElvUI_EltreumUI:ShadowColor(frame.Power.shadow)
											end
											frame.shadow:ClearAllPoints()
											frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											frame.shadow:SetPoint("TOPLEFT", frame.Health,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											frame.shadow:SetPoint("TOPRIGHT", frame.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									end
								end
								if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
									frame.shadow:ClearAllPoints()
									frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.party.power.enable and E.db.unitframe.units.party.power.width == "spaced" then
										frame.shadow:ClearAllPoints()
										frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end
				end

				--party pets
				if E.db.unitframe.units.party.enable and E.db.unitframe.units.party.petsGroup.enable then
					local PartyPetElvUIFrames = {
						_G["ElvUF_PartyGroup1UnitButton1Pet"],
						_G["ElvUF_PartyGroup1UnitButton2Pet"],
						_G["ElvUF_PartyGroup1UnitButton3Pet"],
						_G["ElvUF_PartyGroup1UnitButton4Pet"],
						_G["ElvUF_PartyGroup1UnitButton5Pet"],
					}
					for _, frame in pairs(PartyPetElvUIFrames) do
						if frame and not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end
				end

				--raidpets
				if E.db.unitframe.units.raidpet.enable then
					for i =1, 40 do
						local RaidPetElvUIFrames = {_G["ElvUF_RaidpetGroup1UnitButton"..i]}
						for _, frame in pairs(RaidPetElvUIFrames) do
							if frame and not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end
				end

				--boss
				if E.db.unitframe.units.boss.enable then
					for i = 1, 8 do
						local bossmembers = {_G["ElvUF_Boss"..i]}
						for _, frame in pairs(bossmembers) do
							if not frame.shadow then
								if not (E.db.ElvUI_EltreumUI.borders.bossborder and E.db.ElvUI_EltreumUI.borders.borders) then
									frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
										frame.shadow:ClearAllPoints()
										frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
									if E.db.unitframe.units.boss.power.enable then
										if E.db.unitframe.units.boss.power.width == "spaced" then
											frame.shadow:ClearAllPoints()
											frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											frame.shadow:SetPoint("TOPRIGHT", frame.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											if not frame.Power.shadow then
												frame.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												ElvUI_EltreumUI:ShadowColor(frame.Power.shadow)
											end
										elseif E.db.unitframe.units.boss.power.width == "offset" then
											if E.db.unitframe.units.boss.power.offset >= 0 then
												if not frame.Power.shadow then
													frame.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
													ElvUI_EltreumUI:ShadowColor(frame.Power.shadow)
												end
												frame.shadow:ClearAllPoints()
												frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												frame.shadow:SetPoint("TOPLEFT", frame.Health,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												frame.shadow:SetPoint("TOPRIGHT", frame.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
									ElvUI_EltreumUI:ShadowColor(frame.shadow)
								end
							end
							--[[for _, button in pairs(bossmembers) do
								if not button.shadow then
									button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end]]
						end
					end
				end

				--tank targets
				if E.db.unitframe.units.tank.enable and E.db.unitframe.units.tank.targetsGroup.enable then
					for i = 1, 8 do
						local tanktargetmembers = {_G["ElvUF_TankUnitButton"..i.."Target"]}
						for _, frame in pairs(tanktargetmembers) do
							if not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
									frame.shadow:ClearAllPoints()
									frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end
				end

				--assist targets
				if E.db.unitframe.units.assist.enable and E.db.unitframe.units.assist.targetsGroup.enable then
					for i = 1, 8 do
						local assisttargetmembers = {_G["ElvUF_AssistUnitButton"..i.."Target"]}
						for _, frame in pairs(assisttargetmembers) do
							if not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
									frame.shadow:ClearAllPoints()
									frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						end
					end
				end

				--runes
				if E.myclass == 'DEATHKNIGHT' then
					for i = 1, 6 do
						if not _G["ElvUF_PlayerRuneButton"..i] then
							break
						end
						local button = _G["ElvUF_PlayerRuneButton"..i] --.backdrop
						if not button then
							break
						else
							if not button.shadow and (E.db.unitframe.units.player.classbar.fill == "spaced" or E.db.unitframe.units.player.classbar.detachFromFrame) then
								button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(button.shadow)
							end
						end
					end
				end

				--player classbar
				if E.db.unitframe.units.player.classbar.enable then
					 if E.db.unitframe.units.player.classbar.fill ~= "spaced" then
						if _G["ElvUF_Player_ClassBar"] and not _G["ElvUF_Player_ClassBar"].shadow then
							_G["ElvUF_Player_ClassBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_ClassBar"].shadow)
						end
					else
						if _G["ElvUF_Player_AdditionalPowerBar"] and not _G["ElvUF_Player_AdditionalPowerBar"].shadow then
							_G["ElvUF_Player_AdditionalPowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_AdditionalPowerBar"].shadow)
						end
						if _G["ElvUF_Player_Stagger"] and not _G["ElvUF_Player_Stagger"].shadow then
							_G["ElvUF_Player_Stagger"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_Stagger"].shadow)
						end
					end
				end

				--classpower
				if E.myclass ~= 'DEATHKNIGHT' and not (E.db.ElvUI_EltreumUI.borders.comboclassbar and E.db.ElvUI_EltreumUI.borders.borders) then
					for i = 1, 10 do
						if not _G["ElvUF_PlayerClassIconButton"..i] then
							break
						end
						local button = _G["ElvUF_PlayerClassIconButton"..i].backdrop
						if not button then
							break
						else
							if not button.shadow then
								button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(button.shadow)
							end
						end
					end
				end

				--player power
				if E.db.unitframe.units.player.power.width ~= "spaced" and E.db.unitframe.units.player.power.enable then
					if not E.db.unitframe.units.player.power.detachFromFrame then
						if not (E.db.unitframe.units.player.power.width == "offset" and E.db.unitframe.units.player.power.offset > 0) then
							if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
								_G["ElvUF_Player_PowerBar"].shadow:Hide()
							end
						end
						if _G["ElvUF_Player_HealthBar"] and _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player"].shadow)
						end
						if E.db.unitframe.units.player.classbar.enable then
							if not E.db.unitframe.units.player.classbar.detachFromFrame then
								if E.db.unitframe.units.player.classbar.fill == "spaced" then
									if E.db.unitframe.units.player.power.width == "inset" then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Player_ClassBar"]:IsShown() then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									elseif E.db.unitframe.units.player.power.width == "fill" then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Player_ClassBar"]:IsShown() then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									else
										if E.db.unitframe.units.player.power.offset == 0 then
											if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
												if E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
													_G["ElvUF_Player"].shadow:ClearAllPoints()
													if E.db.unitframe.units.player.orientation == "RIGHT" then
														_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
														_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													elseif E.db.unitframe.units.player.orientation == "LEFT" then
														_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
														_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													end
												end
											end
										else
											if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
												if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
													_G["ElvUF_Player_PowerBar"].shadow:Show()
												end
												if E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
													_G["ElvUF_Player"].shadow:ClearAllPoints()
													if E.db.unitframe.units.player.orientation == "RIGHT" then
														_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
														_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													elseif E.db.unitframe.units.player.orientation == "LEFT" then
														_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
														_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													end
												end
											end
										end
									end
								else
									if E.db.unitframe.units.player.power.width == "inset" then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length + (E.db.unitframe.units.player.classbar.height/1.2))
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Player_ClassBar"]:IsShown() then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									elseif E.db.unitframe.units.player.power.width == "fill" then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									else
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									end
								end
							else
								if E.db.unitframe.units.player.power.width == "inset" then
									if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
										_G["ElvUF_Player"].shadow:ClearAllPoints()
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if not E.db.unitframe.units.player.classbar.detachFromFrame then
											if _G["ElvUF_Player_ClassBar"]:IsShown() then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								elseif E.db.unitframe.units.player.power.width == "fill" then
									if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
										_G["ElvUF_Player"].shadow:ClearAllPoints()
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if not E.db.unitframe.units.player.classbar.detachFromFrame then
											if _G["ElvUF_Player_ClassBar"]:IsShown() then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
												_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								else
									if E.db.unitframe.units.player.power.offset == 0 then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									else
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
												_G["ElvUF_Player_PowerBar"].shadow:Show()
											end
										end
									end
								end
							end
						else
							if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style ~= "3D" and not benikdettached then
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								if E.db.unitframe.units.player.power.width == "inset" then
									if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
										_G["ElvUF_Player"].shadow:ClearAllPoints()
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if _G["ElvUF_Player_ClassBar"]:IsShown() then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									end
								elseif E.db.unitframe.units.player.power.width == "fill" then
									if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
										_G["ElvUF_Player"].shadow:ClearAllPoints()
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if _G["ElvUF_Player_ClassBar"]:IsShown() then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2))
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									end
								else
									if E.db.unitframe.units.player.power.offset == 0 then
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												if E.db.unitframe.units.player.orientation == "RIGHT" then
													_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.player.orientation == "LEFT" then
													_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									else
										if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
											_G["ElvUF_Player"].shadow:ClearAllPoints()
											_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
											if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
												_G["ElvUF_Player_PowerBar"].shadow:Show()
											end
											if E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
												_G["ElvUF_Player"].shadow:ClearAllPoints()
												if E.db.unitframe.units.player.orientation == "RIGHT" then
													_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												elseif E.db.unitframe.units.player.orientation == "LEFT" then
													_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
													_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												end
											end
										end
									end
								end
							end
						end
					else
						if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player"].shadow)
						end
						if _G["ElvUF_Player_HealthBar"] and _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if E.db.unitframe.units.player.classbar.enable then
							if not E.db.unitframe.units.player.classbar.detachFromFrame then
								if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
									_G["ElvUF_Player"].shadow:ClearAllPoints()
									_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									if (_G["ElvUF_Player_ClassBar"] and _G["ElvUF_Player_ClassBar"]:IsShown()) or (_G["ElvUF_Player_AdditionalPowerBar"] and _G["ElvUF_Player_AdditionalPowerBar"]:IsShown()) or (_G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"]:IsShown()) or (_G.ElvUF_Player.Totems and _G.ElvUF_Player.Totems:IsVisible()) or (_G.ElvUF_Player_Runes and _G.ElvUF_Player_Runes:IsVisible()) then
										_G["ElvUF_Player"].shadow:ClearAllPoints()
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length, (E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db.unitframe.units.player.classbar.height/2)))
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							else
								if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
									_G["ElvUF_Player"].shadow:ClearAllPoints()
									_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						else
							if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
								_G["ElvUF_Player"].shadow:ClearAllPoints()
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
					end
				end

				--target power
				if E.db.unitframe.units.target.power.width ~= "spaced" and E.db.unitframe.units.target.power.enable then
					if not E.db.unitframe.units.target.power.detachFromFrame then
						if not (E.db.unitframe.units.target.power.width == "offset" and E.db.unitframe.units.target.power.offset > 0) then
							if _G["ElvUF_Target_PowerBar"].shadow then
								_G["ElvUF_Target_PowerBar"].shadow:Hide()
							end
						end
						if _G["ElvUF_Target_HealthBar"] and _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target"].shadow)
						end
						if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style ~= "3D" and not benikdettached then
							if E.db.unitframe.units.target.power.width == "offset" then
								if E.db.unitframe.units.target.power.offset == 0 then
									if E.db.unitframe.units.target.orientation == "LEFT" then
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									elseif E.db.unitframe.units.target.orientation == "RIGHT" then
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if E.db.unitframe.units.target.orientation == "LEFT" then
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									elseif E.db.unitframe.units.target.orientation == "RIGHT" then
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							else
								if E.db.unitframe.units.target.orientation == "LEFT" then
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.target.orientation == "RIGHT" then
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						else
							if E.db.unitframe.units.target.power.width == "inset" then
								if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
									_G["ElvUF_Target"].shadow:ClearAllPoints()
									_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							elseif E.db.unitframe.units.target.power.width == "fill" then
								if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
									_G["ElvUF_Target"].shadow:ClearAllPoints()
									_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								if E.db.unitframe.units.target.power.offset == 0 then
									if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
										_G["ElvUF_Target"].shadow:ClearAllPoints()
										_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if E.db.unitframe.units.target.portrait.enable and not E.db.unitframe.units.target.portrait.overlay then
											_G["ElvUF_Target"].shadow:ClearAllPoints()
											if E.db.unitframe.units.target.orientation == "RIGHT" then
												_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											elseif E.db.unitframe.units.target.orientation == "LEFT" then
												_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								else
									if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
										_G["ElvUF_Target"].shadow:ClearAllPoints()
										_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if _G["ElvUF_Target_PowerBar"] and _G["ElvUF_Target_PowerBar"].shadow then
											_G["ElvUF_Target_PowerBar"].shadow:Show()
										end
										if E.db.unitframe.units.target.portrait.enable and not E.db.unitframe.units.target.portrait.overlay then
											_G["ElvUF_Target"].shadow:ClearAllPoints()
											if E.db.unitframe.units.target.orientation == "RIGHT" then
												_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											elseif E.db.unitframe.units.target.orientation == "LEFT" then
												_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								end
							end
						end
					else
						if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target"].shadow)
						end
						if _G["ElvUF_Target_HealthBar"] and _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"].shadow:ClearAllPoints()
							_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
				end

				--target of target power
				if E.db.unitframe.units.targettarget.power.width ~= "spaced" and E.db.unitframe.units.targettarget.power.enable then
					if not E.db.unitframe.units.targettarget.power.detachFromFrame then
						if not (E.db.unitframe.units.targettarget.power.width == "offset" and E.db.unitframe.units.targettarget.power.offset > 0) then
							if _G["ElvUF_TargetTarget_PowerBar"].shadow then
								_G["ElvUF_TargetTarget_PowerBar"].shadow:Hide()
							end
						end
						if _G["ElvUF_TargetTarget_HealthBar"] and _G["ElvUF_TargetTarget_HealthBar"].shadow then
							_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
						if E.db.unitframe.units.targettarget.portrait.enable and E.db.unitframe.units.targettarget.portrait.style ~= "3D" and not benikdettached then
							if E.db.unitframe.units.targettarget.power.width == "offset" then
								if E.db.unitframe.units.targettarget.power.offset == 0 then
									if E.db.unitframe.units.targettarget.orientation == "LEFT" then
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									elseif E.db.unitframe.units.targettarget.orientation == "RIGHT" then
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									if E.db.unitframe.units.targettarget.orientation == "LEFT" then
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									elseif E.db.unitframe.units.targettarget.orientation == "RIGHT" then
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							else
								if E.db.unitframe.units.targettarget.orientation == "LEFT" then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.targettarget.orientation == "RIGHT" then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						else
							if E.db.unitframe.units.targettarget.power.width == "inset" then
								if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
									_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT",_G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							elseif E.db.unitframe.units.targettarget.power.width == "fill" then
								if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
									_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								if E.db.unitframe.units.targettarget.power.offset == 0 then
									if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
										_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if E.db.unitframe.units.targettarget.portrait.enable and not E.db.unitframe.units.targettarget.portrait.overlay then
											_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
											if E.db.unitframe.units.targettarget.orientation == "RIGHT" then
												_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											elseif E.db.unitframe.units.targettarget.orientation == "LEFT" then
												_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								else
									if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
										_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
										_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										if _G["ElvUF_TargetTarget_PowerBar"] and _G["ElvUF_TargetTarget_PowerBar"].shadow then
											_G["ElvUF_TargetTarget_PowerBar"].shadow:Show()
										end
										if E.db.unitframe.units.targettarget.portrait.enable and not E.db.unitframe.units.targettarget.portrait.overlay then
											_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
											if E.db.unitframe.units.targettarget.orientation == "RIGHT" then
												_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											elseif E.db.unitframe.units.targettarget.orientation == "LEFT" then
												_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
												_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											end
										end
									end
								end
							end
						end
					else
						if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
								_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
						if _G["ElvUF_TargetTarget_HealthBar"] and _G["ElvUF_TargetTarget_HealthBar"].shadow then
							_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
							_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
				end

				--info panel on top
				if E.db.ElvUI_EltreumUI.unitframes.infopanelontop then
					if (E.db.unitframe.units.player.infoPanel.enable and _G["ElvUF_Player"].USE_INFO_PANEL) and not (E.db.ElvUI_EltreumUI.borders.playerborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player"].shadow)
						end
						if _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"].shadow:Show()
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style ~= "3D" and not benikdettached and not _G["ElvUF_Player"].USE_PORTRAIT_OVERLAY then
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							if E.db.unitframe.units.player.power.enable then
								if E.db.unitframe.units.player.power.width == "fill" then
									if E.db.unitframe.thinBorders then
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length-2)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length-2)
									end
								end
							end
							if (E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.classbar.enable) or (E.db.unitframe.units.player.power.detachFromFrame and E.db.unitframe.units.player.power.enable) then
								if E.db.unitframe.units.player.classbar.detachFromFrame and not E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif not E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							end
						end
					end
					if (E.db.unitframe.units.target.infoPanel.enable and _G["ElvUF_Target"].USE_INFO_PANEL) and not (E.db.ElvUI_EltreumUI.borders.targetborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target"].shadow)
						end
						if _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-2, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-2, E.db.ElvUI_EltreumUI.skins.shadow.length+2)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length+2)
							end
							local benikdettachedtarget = false
							if IsAddOnLoaded("ElvUI_BenikUI") then
								benikdettachedtarget = E.db.benikui.unitframes.target.detachPortrait
							end
							if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style ~= "3D" and not benikdettachedtarget and not _G["ElvUF_Target"].USE_PORTRAIT_OVERLAY then
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"].Portrait,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							if E.db.unitframe.units.target.power.enable then
								if E.db.unitframe.units.target.power.width == "fill" then
									if E.db.unitframe.thinBorders then
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length-2)
										_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length-2)
									end
								end
							end
							if E.db.unitframe.units.target.power.detachFromFrame then
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
					end
					if (E.db.unitframe.units.targettarget.infoPanel.enable and _G["ElvUF_TargetTarget"].USE_INFO_PANEL) and not (E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_TargetTarget_HealthBar"].shadow then
							_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
						if _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db.unitframe.units.targettarget.power.enable then
								if E.db.unitframe.units.targettarget.power.width == "inset" then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_PowerBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
					end
					if (E.db.unitframe.units.pet.infoPanel.enable and _G["ElvUF_Pet"].USE_INFO_PANEL) and not (E.db.ElvUI_EltreumUI.borders.petborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_Pet_HealthBar"].shadow then
							_G["ElvUF_Pet_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Pet"].shadow then
							_G["ElvUF_Pet"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if _G["ElvUF_Pet"].shadow then
							_G["ElvUF_Pet"].shadow:Show()
							_G["ElvUF_Pet"].shadow:ClearAllPoints()
							_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db.unitframe.units.pet.portrait.enable then
								_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							if E.db.unitframe.units.pet.power.enable then
								if E.db.unitframe.units.pet.power.width == "inset" then
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Pet"].shadow)
						end
					end
					if (E.db.ElvUI_EltreumUI.borders.playerborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"].shadow:Hide()
						end
					end
					if (E.db.ElvUI_EltreumUI.borders.targetborder and E.db.ElvUI_EltreumUI.borders.borders) then
						if _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"].shadow:Hide()
						end
					end
				else
					if E.db.unitframe.units.player.infoPanel.enable and _G["ElvUF_Player"].USE_INFO_PANEL then
						if _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player"].shadow)
						end
						if _G["ElvUF_Player"].shadow then
							_G["ElvUF_Player"].shadow:Show()
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style ~= "3D" and not benikdettached and not _G["ElvUF_Player"].USE_PORTRAIT_OVERLAY then
									_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style ~= "3D" and not benikdettached and not _G["ElvUF_Player"].USE_PORTRAIT_OVERLAY then
									_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								end
							end
							if (E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.classbar.enable) or (E.db.unitframe.units.player.power.detachFromFrame and E.db.unitframe.units.player.power.enable) then
								if E.db.unitframe.units.player.classbar.detachFromFrame and not E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										if E.db.unitframe.thinBorders then
											_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										else
											_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length)
											_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length+1)
										end
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								elseif not E.db.unitframe.units.player.classbar.detachFromFrame and E.db.unitframe.units.player.power.detachFromFrame then
									if E.db.unitframe.units.player.infoPanel.enable then
										_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									else
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							end
							if E.db.unitframe.units.player.portrait.enable and not E.db.unitframe.units.player.portrait.overlay then
								_G["ElvUF_Player"].shadow:ClearAllPoints()
								if E.db.unitframe.units.player.orientation == "RIGHT" then
									_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.player.orientation == "LEFT" then
									_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						end
					end
					if E.db.unitframe.units.target.infoPanel.enable and _G["ElvUF_Target"].USE_INFO_PANEL then
						if _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target"].shadow)
						end
						if _G["ElvUF_Target"].shadow then
							_G["ElvUF_Target"].shadow:Show()
							_G["ElvUF_Target"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								end
							end
							if (E.db.unitframe.units.target.power.detachFromFrame and E.db.unitframe.units.target.power.enable) then
								if E.db.unitframe.units.target.infoPanel.enable then
									_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if E.db.unitframe.units.target.portrait.enable and not E.db.unitframe.units.target.portrait.overlay then
								_G["ElvUF_Target"].shadow:ClearAllPoints()
								if E.db.unitframe.units.target.orientation == "RIGHT" then
									_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.target.orientation == "LEFT" then
									_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						end
					end
					if E.db.unitframe.units.targettarget.infoPanel.enable and _G["ElvUF_TargetTarget"].USE_INFO_PANEL then
						if _G["ElvUF_TargetTarget_HealthBar"].shadow then
							_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_TargetTarget"].shadow)
						end
						if _G["ElvUF_TargetTarget"].shadow then
							_G["ElvUF_TargetTarget"].shadow:Show()
							_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.targettarget.portrait.enable and E.db.unitframe.units.targettarget.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								if E.db.unitframe.units.targettarget.portrait.enable and E.db.unitframe.units.targettarget.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								end
							end
							if (E.db.unitframe.units.targettarget.power.detachFromFrame and E.db.unitframe.units.targettarget.power.enable) then
								if E.db.unitframe.units.targettarget.infoPanel.enable then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if E.db.unitframe.units.targettarget.portrait.enable and not E.db.unitframe.units.targettarget.portrait.overlay then
								_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
								if E.db.unitframe.units.targettarget.orientation == "RIGHT" then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.targettarget.orientation == "LEFT" then
									_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						end
					end
					if E.db.unitframe.units.pet.infoPanel.enable and _G["ElvUF_Pet"].USE_INFO_PANEL then
						if _G["ElvUF_Pet_HealthBar"].shadow then
							_G["ElvUF_Pet_HealthBar"].shadow:Hide()
						end
						if not _G["ElvUF_Pet"].shadow then
							_G["ElvUF_Pet"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Pet"].shadow)
						end
						if _G["ElvUF_Pet"].shadow then
							_G["ElvUF_Pet"].shadow:Show()
							_G["ElvUF_Pet"].shadow:ClearAllPoints()
							if E.db.unitframe.thinBorders then
								_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db.unitframe.units.pet.portrait.enable and E.db.unitframe.units.pet.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							else
								_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								if E.db.unitframe.units.pet.portrait.enable and E.db.unitframe.units.pet.portrait.style ~= "3D" and not benikdettached then
									_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								end
							end
							if (E.db.unitframe.units.pet.power.detachFromFrame and E.db.unitframe.units.pet.power.enable) then
								if E.db.unitframe.units.pet.infoPanel.enable then
									_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if E.db.unitframe.units.pet.portrait.enable and not E.db.unitframe.units.pet.portrait.overlay then
								_G["ElvUF_Pet"].shadow:ClearAllPoints()
								if E.db.unitframe.units.pet.orientation == "RIGHT" then
									_G["ElvUF_Pet"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Pet"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								elseif E.db.unitframe.units.pet.orientation == "LEFT" then
									_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
						end
					end
					if not E.Classic then
						if E.db.unitframe.units.focus.infoPanel.enable and _G["ElvUF_Focus"].USE_INFO_PANEL then
							if _G["ElvUF_Focus_HealthBar"].shadow then
								_G["ElvUF_Focus_HealthBar"].shadow:Hide()
							end
							if not _G["ElvUF_Focus"].shadow then
								_G["ElvUF_Focus"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Focus"].shadow)
							end
							if _G["ElvUF_Focus"].shadow then
								_G["ElvUF_Focus"].shadow:Show()
								_G["ElvUF_Focus"].shadow:ClearAllPoints()
								if E.db.unitframe.thinBorders then
									_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_HealthBar"] ,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.unitframe.units.focus.portrait.enable and E.db.unitframe.units.focus.portrait.style ~= "3D" and not benikdettached and not _G["ElvUF_Focus"].USE_PORTRAIT_OVERLAY then
										_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								else
									_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_HealthBar"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_HealthBar"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length+1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
									if E.db.unitframe.units.focus.portrait.enable and E.db.unitframe.units.focus.portrait.style ~= "3D" and not benikdettached and not _G["ElvUF_Focus"].USE_PORTRAIT_OVERLAY then
										_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, E.db.ElvUI_EltreumUI.skins.shadow.length+1)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length-1)
									end
								end
								if E.db.unitframe.units.focus.portrait.enable and not E.db.unitframe.units.focus.portrait.overlay then
									_G["ElvUF_Focus"].shadow:ClearAllPoints()
									if E.db.unitframe.units.focus.orientation == "RIGHT" then
										_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									elseif E.db.unitframe.units.focus.orientation == "LEFT" then
										_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_InfoPanel"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
								end
							end
						end
					end
				end

				--player power detached
				if E.db.unitframe.units.player.power.detachFromFrame then
					if _G["ElvUF_Player_PowerBar"].shadow then
						_G["ElvUF_Player_PowerBar"].shadow:Show()
						ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_PowerBar"].shadow)
					end
				end

				--target power detached
				if E.db.unitframe.units.target.power.detachFromFrame then
					if _G["ElvUF_Target_PowerBar"].shadow then
						_G["ElvUF_Target_PowerBar"].shadow:Show()
						ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_PowerBar"].shadow)
					end
				end
			end
		end
		------------------------------------------------------------------------------------------------------bags
		if E.db.ElvUI_EltreumUI.skins.shadow.blizzard then
			if E.private.bags.enable then
				if _G.ElvUI_ContainerFrame and not _G.ElvUI_ContainerFrame.shadow then
					_G["ElvUI_ContainerFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ElvUI_ContainerFrame"].shadow)
				end
				if _G.ElvUI_BankContainerFrame and not _G.ElvUI_BankContainerFrame.shadow then
					_G["ElvUI_BankContainerFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ElvUI_BankContainerFrame"].shadow)
				end
				if _G.ElvUI_BankContainerFrameWarbandHolder and not _G.ElvUI_BankContainerFrameWarbandHolder.shadow then
					_G["ElvUI_BankContainerFrameWarbandHolder"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ElvUI_BankContainerFrameWarbandHolder"].shadow)
				end
			end
		end
		------------------------------------------------------------------------------------------------------chat
		if E.db.ElvUI_EltreumUI.skins.shadow.chat and not (E.db.ElvUI_EltreumUI.borders.chatborder and E.db.ElvUI_EltreumUI.borders.borders) then
			local rightsizex, rightsizey = _G["RightChatMover"]:GetSize()
			RightChatShadow:SetSize(rightsizex, rightsizey)
			RightChatShadow:SetParent(_G["RightChatPanel"].backdrop)
			local leftsizex, leftsizey = _G["LeftChatMover"]:GetSize()
			LeftChatShadow:SetSize(leftsizex, leftsizey)
			LeftChatShadow:SetParent(_G["LeftChatPanel"].backdrop)

			if E.db.datatexts.panels.EltruismDataText and E.db.datatexts.panels.EltruismDataText.enable then
				if _G["RightChatPanel"] and _G["RightChatPanel"].backdrop and not _G["RightChatPanel"].backdrop.shadow then
					_G["RightChatPanel"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(RightChatShadow.shadow)
					_G.RightChatPanel.backdrop.shadow.BottomEdge:Hide()
					_G.RightChatPanel.backdrop.shadow.BottomRightCorner:Hide()
					_G.RightChatPanel.backdrop.shadow.BottomLeftCorner:Hide()
				end
				if _G["LeftChatPanel"] and _G["LeftChatPanel"].backdrop and not _G["LeftChatPanel"].backdrop.shadow then
					_G["LeftChatPanel"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(LeftChatShadow.shadow)
					_G.LeftChatPanel.backdrop.shadow.BottomEdge:Hide()
					_G.LeftChatPanel.backdrop.shadow.BottomRightCorner:Hide()
					_G.LeftChatPanel.backdrop.shadow.BottomLeftCorner:Hide()
				end
			else
				if not (self.RightChatIsSkinned) then
					RightChatShadow.shadow = RightChatShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					RightChatShadow:SetPoint("TOPRIGHT", _G["RightChatPanel"] ,"TOPRIGHT", 0, 0)
					if E.db.datatexts.panels.RightChatDataPanel.enable then
						RightChatShadow:SetPoint("BOTTOMLEFT", _G["RightChatDataPanel"] ,"BOTTOMLEFT", 0, 0)
					else
						RightChatShadow:SetPoint("BOTTOMLEFT", _G["RightChatPanel"] ,"BOTTOMLEFT", 0, 0)
					end
					RightChatShadow:Show()
					ElvUI_EltreumUI:ShadowColor(RightChatShadow.shadow)
					self.RightChatIsSkinned = true
				end
				if not (self.LeftChatIsSkinned) then
					LeftChatShadow.shadow = LeftChatShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					LeftChatShadow:SetPoint("TOPLEFT", _G["LeftChatPanel"] ,"TOPLEFT", 0, 0)
					if E.db.datatexts.panels.LeftChatDataPanel.enable then
						LeftChatShadow:SetPoint("BOTTOMRIGHT", _G["LeftChatDataPanel"] ,"BOTTOMRIGHT", 0, 0)
					else
						LeftChatShadow:SetPoint("BOTTOMRIGHT", _G["LeftChatPanel"] ,"BOTTOMRIGHT", 0, 0)
					end
					LeftChatShadow:Show()
					ElvUI_EltreumUI:ShadowColor(LeftChatShadow.shadow)
					self.LeftChatIsSkinned = true
				end
			end
			if E.db.chat.panelBackdrop == "LEFT" then
				RightChatShadow:Hide()
			elseif E.db.chat.panelBackdrop == "RIGHT" then
				LeftChatShadow:Hide()
			elseif E.db.chat.panelBackdrop == "HIDEBOTH" then
				LeftChatShadow:Hide()
				RightChatShadow:Hide()
			end
		end
		------------------------------------------------------------------------------------------------------other addons
		if IsAddOnLoaded('ProjectAzilroka') then
			if _G.stAMFrame and not _G.stAMFrame.shadow then
				_G.stAMFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G.stAMFrame.shadow)
			end

			if _G.stAMProfileMenu and not _G.stAMProfileMenu.shadow then
				_G.stAMProfileMenu:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G.stAMProfileMenu.shadow)
			end

			if _G.SquareMinimapButtonBar and not _G.SquareMinimapButtonBar.shadow then
				_G.SquareMinimapButtonBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G.SquareMinimapButtonBar.shadow)
			end
		end

		if IsAddOnLoaded("ElvUI_WindTools") then
			if _G["WTEventTracker"] and _G["WTEventTracker"].backdrop and not _G["WTEventTracker"].backdrop.shadow then
				_G["WTEventTracker"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["WTEventTracker"].backdrop.shadow)
			end
			if _G["WTContacts"] and not _G["WTContacts"].shadow then
				_G["WTContacts"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["WTContacts"].shadow)
			end

			if E.db.WT.misc.gameBar.enable and E.db.WT.misc.gameBar.backdrop then
				if _G["WTGameBarMiddlePanel"] and not _G["WTGameBarMiddlePanel"].shadow then
					_G["WTGameBarMiddlePanel"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["WTGameBarMiddlePanel"].shadow)
				end
				if _G["WTGameBarLeftPanel"] and not _G["WTGameBarLeftPanel"].shadow then
					_G["WTGameBarLeftPanel"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["WTGameBarLeftPanel"].shadow)
				end
				if _G["WTGameBarRightPanel"] and not _G["WTGameBarRightPanel"].shadow then
					_G["WTGameBarRightPanel"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["WTGameBarRightPanel"].shadow)
				end
			end

			for i = 1, 5 do
				if _G["WTExtraItemsBar"..i] then
					if _G["WTExtraItemsBar"..i].backdrop and _G["WTExtraItemsBar"..i].backdrop:IsShown() then
						if not _G["WTExtraItemsBar"..i].backdrop.shadow then
							_G["WTExtraItemsBar"..i].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["WTExtraItemsBar"..i].backdrop.shadow)
						end
					else
						for k = 1, 12 do
							if _G["WTExtraItemsBar"..i.."Button"..k] and not _G["WTExtraItemsBar"..i.."Button"..k].shadow then
								_G["WTExtraItemsBar"..i.."Button"..k]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(_G["WTExtraItemsBar"..i.."Button"..k].shadow)
							end
						end
					end
				end
			end

			local WT = E.Libs.AceAddon:GetAddon("ElvUI_WindTools", true)
			local MB = WT:GetModule("MinimapButtons")
			if MB and MB.bar then
				if MB.bar.backdrop and MB.bar.backdrop:IsShown() then
					MB.bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(MB.bar.shadow)
				else
					if MB.SetButtonMouseOver then
						hooksecurefunc(MB,"SetButtonMouseOver", function(_,button)
							if button and button.backdrop and not button.backdrop.shadow then
								button.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(button.backdrop.shadow)
							end
						end)
					end
					for _, v in pairs({MB.bar:GetChildren()}) do
						if v and v.backdrop and not v.backdrop.shadow then
							v.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(v.backdrop.shadow)
						end
					end
				end
			end
			local LL = WT:GetModule("LFGList")
			if LL and LL.UpdateRightPanel then
				hooksecurefunc(LL,"UpdateRightPanel", function()
					if LL.rightPanel and not LL.rightPanel.shadow then
						LL.rightPanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(LL.rightPanel.shadow)
					end
				end)
			end

			if _G["ParagonReputation_Toast"] and not _G["ParagonReputation_Toast"].shadow then
				_G["ParagonReputation_Toast"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["ParagonReputation_Toast"].shadow)
			end

			if E.db.WT.item.inspect.player then
				if _G["PaperDollFrame"] then
					_G["PaperDollFrame"]:HookScript("OnShow",function()
						if _G["PaperDollFrame"].inspectFrame and _G["PaperDollFrame"].inspectFrame.backdrop and not _G["PaperDollFrame"].inspectFrame.backdrop.shadow then
							_G["PaperDollFrame"].inspectFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["PaperDollFrame"].inspectFrame.backdrop.shadow)
						end
					end)
				end
			end

			local RM = WT:GetModule("RaidMarkers")
			if RM and RM.bar then
				if RM.bar.backdrop and RM.bar.backdrop:IsShown() then
					if not RM.bar.backdrop.shadow then
						RM.bar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(RM.bar.backdrop.shadow)
					end
				else
					for i = 1, RM.bar:GetNumChildren() do
						local button = select(i, RM.bar:GetChildren())
						if button and button.backdrop and button.backdrop:IsShown() and not button.backdrop.shadow then
							button.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(button.backdrop.shadow)
						end
					end
				end
			end
		end

		if IsAddOnLoaded("Leatrix_Maps") then --leatrix map issues
			if LeaMapsDB["NoMapBorder"] == "On" then
				if _G.WorldMapFrame and _G.WorldMapFrame.shadow then
					_G.WorldMapFrame.shadow:Hide()
				end
			end
		end
	end
end

function ElvUI_EltreumUI:RaidShadows()
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
		--raid
		if E.db.unitframe.units.raid1.enable or E.db.unitframe.units.raid2.enable or E.db.unitframe.units.raid3.enable then
			for i = 1, 3 do
				for k = 1, 8 do
					for l = 1, 5 do
						local slots = {_G["ElvUF_Raid"..i..'Group'..k..'UnitButton'..l]}
						for _, button in pairs(slots) do
							if button and not button.shadow then
								if button.db.power.enable then
									if button.db.power.width == "spaced" then
										button.Health:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.Health.shadow:SetParent(button)
										ElvUI_EltreumUI:ShadowColor(button.Health.shadow)
										button.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.Power.shadow:SetParent(button)
										ElvUI_EltreumUI:ShadowColor(button.Power.shadow)
									elseif button.db.power.width == "offset" then
										button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.shadow:SetParent(button)
										ElvUI_EltreumUI:ShadowColor(button.shadow)
										if button.db.power.offset > 0 then
											if not button.Power.shadow then
												button.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												button.Power.shadow:SetParent(button)
												ElvUI_EltreumUI:ShadowColor(button.Power.shadow)
											end
											button.shadow:ClearAllPoints()
											button.shadow:SetPoint("BOTTOMLEFT", button.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("BOTTOMRIGHT", button.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("TOPLEFT", button.Health,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("TOPRIGHT", button.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									else
										button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes and button.db.infoPanel.enable then
											button.shadow:ClearAllPoints()
											button.shadow:SetPoint("BOTTOMLEFT", button.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("BOTTOMRIGHT", button.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("TOPLEFT", button.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
											button.shadow:SetPoint("TOPRIGHT", button.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
										button.shadow:SetParent(button)
										ElvUI_EltreumUI:ShadowColor(button.shadow)
									end
								else
									button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes and button.db.infoPanel.enable then
										button.shadow:ClearAllPoints()
										button.shadow:SetPoint("BOTTOMLEFT", button.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.shadow:SetPoint("BOTTOMRIGHT", button.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.shadow:SetPoint("TOPLEFT", button.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
										button.shadow:SetPoint("TOPRIGHT", button.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									end
									button.shadow:SetParent(button)
									ElvUI_EltreumUI:ShadowColor(button.shadow)
								end
							end
						end
					end
				end
			end
		end

		--tanks
		if E.db.unitframe.units.tank.enable then
			for i = 1, 8 do
				local tankmembers = {_G["ElvUF_TankUnitButton"..i]}
				for _, frame in pairs(tankmembers) do
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
							frame.shadow:ClearAllPoints()
							frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end
		end

		--assists
		if E.db.unitframe.units.assist.enable then
			for i = 1, 8 do
				local assistmembers = {_G["ElvUF_AssistUnitButton"..i]}
				for _, frame in pairs(assistmembers) do
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
							frame.shadow:ClearAllPoints()
							frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end
		end
	end
end

--benik's version
function ElvUI_EltreumUI:NameplateShadows(nameplate)
	if not nameplate then return end
	if E.private.nameplates.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable then

		if E.db.ElvUI_EltreumUI.skins.shadow.nameplates then
			if not nameplate.Health then return end
			if nameplate.Health.backdrop and not nameplate.Health.backdrop.shadow then
				nameplate.Health.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(nameplate.Health.backdrop.shadow)
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
			if not nameplate.Power then return end
			if nameplate.Power.backdrop and not nameplate.Power.backdrop.shadow then
				nameplate.Power.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(nameplate.Power.backdrop.shadow)
			end
			if _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"].shadow then
				_G["ElvNP_TargetClassPowerClassPower"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["ElvNP_TargetClassPowerClassPower"].shadow)
			end
			if _G["ElvNP_TargetClassPowerRunes"] and not _G["ElvNP_TargetClassPowerRunes"].shadow then
				_G["ElvNP_TargetClassPowerRunes"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["ElvNP_TargetClassPowerRunes"].shadow)
			end
			if _G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"].shadow then
				_G["ElvNP_TargetClassPowerStagger"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["ElvNP_TargetClassPowerStagger"].shadow)
			end
			if _G["EltruismPowerBar"] and not _G["EltruismPowerBar"].shadow then
				_G["EltruismPowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["EltruismPowerBar"].shadow)
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.npcastbar then
			if not nameplate.Castbar then return end
			if nameplate.Castbar.backdrop and not nameplate.Castbar.backdrop.shadow then
				nameplate.Castbar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(nameplate.Castbar.backdrop.shadow)
			end

			if nameplate.Castbar.Button and not nameplate.Castbar.Button.shadow then
				nameplate.Castbar.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(nameplate.Castbar.Button.shadow)
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.npportraits then
			if not nameplate.Portrait then return end
			if nameplate.Portrait.backdrop and not nameplate.Portrait.backdrop.shadow then
				nameplate.Portrait.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(nameplate.Portrait.backdrop.shadow)
			end
		end
	end
end
hooksecurefunc(NP, 'StylePlate', ElvUI_EltreumUI.NameplateShadows) --nameplate shadows

function ElvUI_EltreumUI:Construct_AuraIcon(button)
	if not button then return end
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.npauras then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(button.shadow)
		end
	end
end
hooksecurefunc(NP, 'Construct_AuraIcon', ElvUI_EltreumUI.Construct_AuraIcon) --nameplate buffs/debuffs shadows

function ElvUI_EltreumUI:AuraShadows(button)
	if not button then return end
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborder) and not IsAddOnLoaded("Masque") then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(button.shadow)
		end
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraShadows) --aura (minimap) shadows

function ElvUI_EltreumUI:UFAuraShadows(button)
	if not button then return end
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.ufaura and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborderuf) then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(button.shadow)
		end
	end
end
hooksecurefunc(UF, 'Construct_AuraIcon', ElvUI_EltreumUI.UFAuraShadows) --uf aura shadows

--from elvui chat bubbles
local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 0.1
local M = E:GetModule('Misc')
function ElvUI_EltreumUI:ChatBubblesShadows()
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not self.ChatShadowsHooked and (E.private.general.chatBubbles == "backdrop" or E.private.general.chatBubbles == "backdrop_noborder") then
		M.BubbleFrame:HookScript("OnUpdate",function(_,elapsed)
			TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
			if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
				TimeSinceLastUpdate = 0
				for _, frame in pairs(C_ChatBubbles.GetAllChatBubbles()) do
					local holder = frame:GetChildren()
					if holder and not holder:IsForbidden() then
						if E.private.general.chatBubbles == "backdrop" then
							if not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						elseif E.private.general.chatBubbles == "backdrop_noborder" then
							if not holder.shadow then
								holder:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								holder.shadow:ClearAllPoints()
								holder.shadow:SetPoint("TOPLEFT", holder.Center, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								holder.shadow:SetPoint("BOTTOMRIGHT", holder.Center, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(holder.shadow)
							end
						end
					end
				end
			end
		end)
		self.ChatShadowsHooked = true
	end
end
hooksecurefunc(M, "LoadChatBubbles", ElvUI_EltreumUI.ChatBubblesShadows)

--Datatexts
function ElvUI_EltreumUI:DataTextShadows(name)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.datatexts then
		local panel = DT:FetchFrame(name)
		if not panel then return end
		E:Delay(0.5, function() --needs a delay to wait for the panel setup
			if not panel.template then return end
			if panel.template ~= 'NoBackdrop' then
				panel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(panel.shadow)
			end
		end)

	end
end
hooksecurefunc(DT,"BuildPanelFrame", ElvUI_EltreumUI.DataTextShadows)
