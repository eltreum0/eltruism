local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local A = E:GetModule('Auras')
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end
local EltruismBlizzShadows = CreateFrame("Frame")
local MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
local RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
local LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
local timermonitor = CreateFrame("FRAME")
local select = _G.select

--Frame Shadows, turns out ElvUI includes the function
function ElvUI_EltreumUI:Shadows()
	if E.db.ElvUI_EltreumUI.skins.shadow.enable then
		------------------------------------------------------------------------------------------------------blizzard frames
		EltruismBlizzShadows:RegisterEvent("ADDON_LOADED")
		EltruismBlizzShadows:RegisterEvent("PLAYER_ENTERING_WORLD")
		EltruismBlizzShadows:SetScript("OnEvent", function(_, _, arg)
			if (arg == "Blizzard_PerksProgram") or IsAddOnLoaded("Blizzard_PerksProgram") then
				if _G.PerksProgramFrame then
					if _G.PerksProgramFrame.ProductsFrame then
						if _G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame and not _G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.shadow then
							_G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.shadow) end
						end
						if _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter then
							if _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton and not _G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton.shadow then
								_G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.ProductsFrame.PerksProgramFilter.FilterDropDownButton.shadow) end
							end
						end
						if _G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer and not _G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.shadow then
							_G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.shadow) end
						end
						if _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame and not _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow then
							_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow) end --might break shadow
							_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:ClearAllPoints()
							_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:SetPoint("TOPLEFT", _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.Icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PerksProgramFrame.ProductsFrame.PerksProgramCurrencyFrame.Icon, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if _G.PerksProgramFrame.FooterFrame then
						if _G.PerksProgramFrame.FooterFrame.PurchaseButton and not _G.PerksProgramFrame.FooterFrame.PurchaseButton.shadow then
							_G.PerksProgramFrame.FooterFrame.PurchaseButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.PurchaseButton.shadow) end
						end
						if _G.PerksProgramFrame.FooterFrame.ToggleHideArmor and not _G.PerksProgramFrame.FooterFrame.ToggleHideArmor.shadow then
							_G.PerksProgramFrame.FooterFrame.ToggleHideArmor:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.ToggleHideArmor.shadow) end
						end
						if _G.PerksProgramFrame.FooterFrame.LeaveButton and not _G.PerksProgramFrame.FooterFrame.LeaveButton.shadow then
							_G.PerksProgramFrame.FooterFrame.LeaveButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.LeaveButton.shadow) end
						end
						if _G.PerksProgramFrame.FooterFrame and _G.PerksProgramFrame.FooterFrame.RotateButtonContainer then
							if _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton and not _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton.shadow then
								_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateRightButton.shadow) end
							end
							if _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton and not _G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton.shadow then
								_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.RotateButtonContainer.RotateLeftButton.shadow) end
							end
							if (_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview and _G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop) and not _G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop.shadow then
								_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PerksProgramFrame.FooterFrame.TogglePlayerPreview.backdrop.shadow) end
							end
						end
					end
				end
			end
			if (arg == "Blizzard_ProfessionsCustomerOrders") or IsAddOnLoaded("Blizzard_ProfessionsCustomerOrders") then
				if _G.ProfessionsCustomerOrdersFrame and not _G.ProfessionsCustomerOrdersFrame.shadow then
					_G.ProfessionsCustomerOrdersFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ProfessionsCustomerOrdersFrame.shadow) end
				end
				if _G.ProfessionsCustomerOrdersFrameBrowseTab and _G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop and not _G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop.shadow then
					_G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop.shadow) end
				end
				if _G.ProfessionsCustomerOrdersFrameOrdersTab and _G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop and not _G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop.shadow then
					_G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop.shadow) end
				end
			end
			if (arg == "Blizzard_GenericTraitUI") or IsAddOnLoaded("Blizzard_GenericTraitUI") then
				if _G.GenericTraitFrame and not _G.GenericTraitFrame.shadow then
					_G.GenericTraitFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GenericTraitFrame.shadow) end
				end
			end
			if (arg == "Blizzard_ClassTalentUI") or IsAddOnLoaded("Blizzard_ClassTalentUI") then
				if _G.ClassTalentFrame and not _G.ClassTalentFrame.shadow then
					_G.ClassTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClassTalentFrame.shadow) end
					if _G.ClassTalentFrame.TabSystem then
						for i = 1, _G.ClassTalentFrame.TabSystem:GetNumChildren() do
							local tab = select(i, _G.ClassTalentFrame.TabSystem:GetChildren())
							if tab and tab.backdrop and not tab.backdrop.shadow then
								tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(tab.backdrop.shadow) end
							end
						end
					end
				end
				if _G.ClassTalentLoadoutImportDialog then
					_G.ClassTalentLoadoutImportDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClassTalentLoadoutImportDialog.shadow) end
				end
			end
			if (arg == "Blizzard_ItemInteractionUI") or IsAddOnLoaded("Blizzard_ItemInteractionUI") then
				if _G.ItemInteractionFrame and not _G.ItemInteractionFrame.shadow then
					_G.ItemInteractionFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ItemInteractionFrame.shadow) end
				end
			end
			if (arg == "Blizzard_OrderHallUI") or IsAddOnLoaded("Blizzard_OrderHallUI") then
				if _G.OrderHallCommandBar and not _G.OrderHallCommandBar.shadow then
					_G.OrderHallCommandBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.OrderHallCommandBar.shadow) end
				end
				if _G.OrderHallTalentFrame and not _G.OrderHallTalentFrame.shadow then
					_G.OrderHallTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.OrderHallTalentFrame.shadow) end
				end
			end
			if (arg == "Blizzard_ArchaeologyUI") or IsAddOnLoaded("Blizzard_ArchaeologyUI") then
				if _G.ArcheologyDigsiteProgressBar and _G.ArcheologyDigsiteProgressBar.FillBar and not _G.ArcheologyDigsiteProgressBar.FillBar.shadow then
					_G.ArcheologyDigsiteProgressBar.FillBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ArcheologyDigsiteProgressBar.FillBar.shadow) end
				end
			end
			if (arg == "Blizzard_MacroUI") or IsAddOnLoaded("Blizzard_MacroUI") then
				if E.Retail or E.Wrath then
					if not _G.MacroFrame.shadow then
						_G.MacroFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.MacroFrame.shadow) end
					end
				elseif E.Classic then
					if _G.MacroFrame and _G.MacroFrame.backdrop and not _G.MacroFrame.backdrop.shadow then
						_G.MacroFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.MacroFrame.backdrop.shadow) end
					end
				end
			end
			if (arg == "Blizzard_DeathRecap") or IsAddOnLoaded("Blizzard_DeathRecap") then
				if not _G.DeathRecapFrame.shadow then
					_G.DeathRecapFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.DeathRecapFrame.shadow) end
				end
			end
			if (arg == "Blizzard_FlightMap") or IsAddOnLoaded("Blizzard_FlightMap") then
				if not _G.FlightMapFrame.shadow then
					_G.FlightMapFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.FlightMapFrame.shadow) end
				end
			end
			if (arg == "Blizzard_GuildBankUI") or IsAddOnLoaded("Blizzard_GuildBankUI") then
				if E.Retail then
					if not _G.GuildBankFrame.shadow then
						_G.GuildBankFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrame.shadow) end
					end
					if not _G.GuildBankTab1.Button.shadow then
						_G.GuildBankTab1.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab1.Button.shadow) end
					end
					if not _G.GuildBankTab2.Button.shadow then
						_G.GuildBankTab2.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab2.Button.shadow) end
					end
					if not _G.GuildBankTab3.Button.shadow then
						_G.GuildBankTab3.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab3.Button.shadow) end
					end
					if not _G.GuildBankTab4.Button.shadow then
						_G.GuildBankTab4.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab4.Button.shadow) end
					end
					if not _G.GuildBankTab5.Button.shadow then
						_G.GuildBankTab5.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab5.Button.shadow) end
					end
					if not _G.GuildBankTab6.Button.shadow then
						_G.GuildBankTab6.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankTab6.Button.shadow) end
					end
					if not _G.GuildBankFrameTab1.backdrop.shadow then
						_G.GuildBankFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrameTab1.backdrop.shadow) end
					end
					if not _G.GuildBankFrameTab2.backdrop.shadow then
						_G.GuildBankFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrameTab2.backdrop.shadow) end
					end
					if not _G.GuildBankFrameTab3.backdrop.shadow then
						_G.GuildBankFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrameTab3.backdrop.shadow) end
					end
					if not _G.GuildBankFrameTab4.backdrop.shadow then
						_G.GuildBankFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrameTab4.backdrop.shadow) end
					end
				else
					if not _G.GuildBankFrame.backdrop.shadow then
						_G.GuildBankFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildBankFrame.backdrop.shadow) end
					end
				end
			end
			if (arg == "Blizzard_TrainerUI") or IsAddOnLoaded("Blizzard_TrainerUI") then
				if E.Retail then
					if not _G.ClassTrainerFrame.shadow then
						_G.ClassTrainerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClassTrainerFrame.shadow) end
					end
				else
					if not _G.ClassTrainerFrame.backdrop.shadow then
						_G.ClassTrainerFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClassTrainerFrame.backdrop.shadow) end
					end
				end
			end
			if (arg == "Blizzard_ItemSocketingUI") or IsAddOnLoaded("Blizzard_ItemSocketingUI") then
				if not _G.ItemSocketingFrame.shadow then
					_G.ItemSocketingFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ItemSocketingFrame.shadow) end
				end
			end
			if (arg == "Blizzard_ItemUpgradeUI") or IsAddOnLoaded("Blizzard_ItemUpgradeUI") then
				if not _G.ItemUpgradeFrame.shadow then
					_G.ItemUpgradeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ItemUpgradeFrame.shadow) end
				end
			end
			if (arg == "Blizzard_TradeSkillUI") or IsAddOnLoaded("Blizzard_TradeSkillUI") then
				if E.Retail then
					if not _G.TradeSkillFrame.shadow then
						_G.TradeSkillFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.TradeSkillFrame.shadow) end
					end
				else
					if not _G.TradeSkillFrame.backdrop.shadow then
						_G.TradeSkillFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.TradeSkillFrame.backdrop.shadow) end
					end
				end
			end
			if (arg == "Blizzard_ChromieTimeUI") or IsAddOnLoaded("Blizzard_ChromieTimetUI") then
				if not _G.ChromieTimeFrame.shadow then
					_G.ChromieTimeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ChromieTimeFrame.shadow) end
				end
			end
			if (arg == "Blizzard_BlackMarketUI") or IsAddOnLoaded("Blizzard_BlackMarketUI") then
				if not _G.BlackMarketFrame.shadow then
					_G.BlackMarketFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.BlackMarketFrame.shadow) end
				end
			end
			if (arg == "Blizzard_BindingUI") or IsAddOnLoaded("Blizzard_BindingUI") then
				if not _G.KeyBindingFrame.shadow then
					_G.KeyBindingFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.KeyBindingFrame.shadow) end
				end
			end
			if (arg == "Blizzard_InspectUI") or IsAddOnLoaded("Blizzard_InspectUI") then
				if E.Retail then
					if _G.InspectFrame and not _G.InspectFrame.shadow then
						_G.InspectFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.InspectFrame.shadow) end
					end
				else
					if _G.InspectFrame and _G.InspectFrame.backdrop and not _G.InspectFrame.backdrop.shadow then
						_G.InspectFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.InspectFrame.backdrop.shadow) end
					end
				end
				if _G.InspectFrameTab1 and _G.InspectFrameTab1.backdrop and not _G.InspectFrameTab1.backdrop.shadow then
					_G.InspectFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.InspectFrameTab1.backdrop.shadow) end
				end
				if _G.InspectFrameTab2 and _G.InspectFrameTab2.backdrop and not _G.InspectFrameTab2.backdrop.shadow then
					_G.InspectFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.InspectFrameTab2.backdrop.shadow) end
				end
				if _G.InspectFrameTab3 and _G.InspectFrameTab3.backdrop and not _G.InspectFrameTab3.backdrop.shadow then
					_G.InspectFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.InspectFrameTab3.backdrop.shadow) end
				end
			end
			if E.private.skins.blizzard.enable then
				if (arg == "Blizzard_TalentUI") or IsAddOnLoaded("Blizzard_TalentUI") then
					if E.Retail then
						if not _G.PlayerTalentFrame.shadow then
							_G.PlayerTalentFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrame.shadow) end
						end
					else
						if _G.PlayerTalentFrame and _G.PlayerTalentFrame.backdrop and not _G.PlayerTalentFrame.backdrop.shadow then
							_G.PlayerTalentFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrame.backdrop.shadow) end
						end
						if _G.PlayerTalentFrameTab3 and _G.PlayerTalentFrameTab3.backdrop and not _G.PlayerTalentFrameTab3.backdrop.shadow then
							_G.PlayerTalentFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrameTab3.backdrop.shadow) end
						end
						if _G.PlayerTalentFrameTab4 and _G.PlayerTalentFrameTab4.backdrop and not _G.PlayerTalentFrameTab4.backdrop.shadow then
							_G.PlayerTalentFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrameTab4.backdrop.shadow) end
						end
						if _G.PlayerSpecTab1 and not _G.PlayerSpecTab1.shadow then
							_G.PlayerSpecTab1:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerSpecTab1.shadow) end
						end
						if _G.PlayerSpecTab2 and not _G.PlayerSpecTab2.shadow then
							_G.PlayerSpecTab2:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerSpecTab2.shadow) end
						end
					end
					if _G.PlayerTalentFrameTab1 and _G.PlayerTalentFrameTab1.backdrop and not _G.PlayerTalentFrameTab1.backdrop.shadow then
						_G.PlayerTalentFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrameTab1.backdrop.shadow) end
					end
					if _G.PlayerTalentFrameTab2 and _G.PlayerTalentFrameTab2.backdrop and not _G.PlayerTalentFrameTab2.backdrop.shadow then
						_G.PlayerTalentFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerTalentFrameTab2.backdrop.shadow) end
					end
				end
				if (arg == "Blizzard_Calendar") or IsAddOnLoaded("Blizzard_Calendar") then
					if not _G.CalendarFrame.shadow then
						_G.CalendarFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CalendarFrame.shadow) end
					end
					if not _G.CalendarViewHolidayFrame.shadow then
						_G.CalendarViewHolidayFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CalendarViewHolidayFrame.shadow) end
					end
				end
				if (arg == "Blizzard_Communities") or IsAddOnLoaded("Blizzard_Communities") then
					if _G.CommunitiesFrame then
						if not _G.CommunitiesFrame.shadow then
							_G.CommunitiesFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.shadow) end
						end
						if _G.CommunitiesFrameTab1 and _G.CommunitiesFrameTab1.backdrop and not _G.CommunitiesFrameTab1.backdrop.shadow then
							_G.CommunitiesFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrameTab1.backdrop.shadow) end
						end
						if _G.CommunitiesFrameTab2 and _G.CommunitiesFrameTab2.backdrop and not _G.CommunitiesFrameTab2.backdrop.shadow then
							_G.CommunitiesFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrameTab2.backdrop.shadow) end
						end
						if _G.CommunitiesFrameTab3 and _G.CommunitiesFrameTab3.backdrop and not _G.CommunitiesFrameTab3.backdrop.shadow then
							_G.CommunitiesFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrameTab3.backdrop.shadow) end
						end
						if _G.CommunitiesFrameTab4 and _G.CommunitiesFrameTab4.backdrop and not _G.CommunitiesFrameTab4.backdrop.shadow then
							_G.CommunitiesFrameTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrameTab4.backdrop.shadow) end
						end
						if _G.CommunitiesFrameTab5 and _G.CommunitiesFrameTab5.backdrop and not _G.CommunitiesFrameTab5.backdrop.shadow then
							_G.CommunitiesFrameTab5.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrameTab5.backdrop.shadow) end
						end
						if _G.CommunitiesFrame.ChatTab and _G.CommunitiesFrame.ChatTab.backdrop and not _G.CommunitiesFrame.ChatTab.backdrop.shadow then
							_G.CommunitiesFrame.ChatTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.ChatTab.backdrop.shadow) end
						end
						if _G.CommunitiesFrame.RosterTab and _G.CommunitiesFrame.RosterTab.backdrop and not _G.CommunitiesFrame.RosterTab.backdrop.shadow then
							_G.CommunitiesFrame.RosterTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.RosterTab.backdrop.shadow) end
						end
						if _G.CommunitiesFrame.GuildBenefitsTab and _G.CommunitiesFrame.GuildBenefitsTab.backdrop and not _G.CommunitiesFrame.GuildBenefitsTab.backdrop.shadow then
							_G.CommunitiesFrame.GuildBenefitsTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.GuildBenefitsTab.backdrop.shadow) end
						end
						if _G.CommunitiesFrame.GuildInfoTab and _G.CommunitiesFrame.GuildInfoTab.backdrop and not _G.CommunitiesFrame.GuildInfoTab.backdrop.shadow then
							_G.CommunitiesFrame.GuildInfoTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.GuildInfoTab.backdrop.shadow) end
						end
						if _G.CommunitiesFrame.GuildMemberDetailFrame and not _G.CommunitiesFrame.GuildMemberDetailFrame.shadow then
							_G.CommunitiesFrame.GuildMemberDetailFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.GuildMemberDetailFrame.shadow) end
						end
						if _G.ClubFinderGuildFinderFrame then
							if _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab and _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop and not _G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow then
								_G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClubFinderGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow) end
							end
							if _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab and _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop and not _G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow then
								_G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClubFinderGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow) end
							end
						end
						if _G.CommunitiesFrame.RecruitmentDialog and not _G.CommunitiesFrame.RecruitmentDialog.shadow then
							_G.CommunitiesFrame.RecruitmentDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesFrame.RecruitmentDialog.shadow) end
						end
						if _G.ClubFinderCommunityAndGuildFinderFrame then
							if _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab and _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop and not _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow then
								_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab.backdrop.shadow) end
							end
							if _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab and _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop and not _G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow then
								_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab.backdrop.shadow) end
							end
						end
					end
				end
				if (arg == "Blizzard_GuildControlUI") or IsAddOnLoaded("Blizzard_GuildControlUI") then
					if _G.CommunitiesGuildLogFrame and not _G.CommunitiesGuildLogFrame.shadow then
						_G.CommunitiesGuildLogFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CommunitiesGuildLogFrame.shadow) end
					end
					if _G.GuildControlUI and not _G.GuildControlUI.shadow then
						_G.GuildControlUI:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GuildControlUI.shadow) end
					end
				end
				if (arg == "Blizzard_AchievementUI") or IsAddOnLoaded("Blizzard_AchievementUI") then
					if E.Retail then
						if _G.AchievementFrame and not _G.AchievementFrame.shadow then
							_G.AchievementFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AchievementFrame.shadow) end
						end
						if _G.AchievementFrameTab3 and _G.AchievementFrameTab3.backdrop and not _G.AchievementFrameTab3.backdrop.shadow then
							_G.AchievementFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AchievementFrameTab3.backdrop.shadow) end
						end
					else
						if _G.AchievementFrame and _G.AchievementFrame.backdrop and not _G.AchievementFrame.backdrop.shadow then
							_G.AchievementFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AchievementFrame.backdrop.shadow) end
						end
					end
					if _G.AchievementFrameTab1 and _G.AchievementFrameTab1.backdrop and not _G.AchievementFrameTab1.backdrop.shadow then
						_G.AchievementFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AchievementFrameTab1.backdrop.shadow) end
					end
					if _G.AchievementFrameTab2 and _G.AchievementFrameTab2.backdrop and not _G.AchievementFrameTab2.backdrop.shadow then
						_G.AchievementFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AchievementFrameTab2.backdrop.shadow) end
					end
				end
				if (arg == "Blizzard_GarrisonUI") or IsAddOnLoaded("Blizzard_GarrisonUI") then
					if _G.GarrisonLandingPage then
						if not _G.GarrisonLandingPage.shadow then
							_G.GarrisonLandingPage:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GarrisonLandingPage.shadow) end
						end
					end
					if _G.CovenantMissionFrame then
						if not _G.CovenantMissionFrame.shadow then
							_G.CovenantMissionFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CovenantMissionFrame.shadow) end
						end
						if not _G.CovenantMissionFrameTab1.backdrop.shadow then
							_G.CovenantMissionFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CovenantMissionFrameTab1.backdrop.shadow) end
						end
						if not _G.CovenantMissionFrameTab2.backdrop.shadow then
							_G.CovenantMissionFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CovenantMissionFrameTab2.backdrop.shadow) end
						end
					end
				end
				if (arg == "Blizzard_CovenantSanctum") or IsAddOnLoaded("Blizzard_CovenantSanctum") then
					if _G.CovenantSanctumFrame then
						if not _G.CovenantSanctumFrame.shadow then
							_G.CovenantSanctumFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CovenantSanctumFrame.shadow) end
						end
					end
				end
				if (arg == "Blizzard_Soulbinds") or IsAddOnLoaded("Blizzard_Soulbinds") then
					if _G.SoulbindViewer then
						if not _G.SoulbindViewer.shadow then
							_G.SoulbindViewer:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.SoulbindViewer.shadow) end
						end
					end
				end
				if (arg == "Blizzard_Collections") or IsAddOnLoaded("Blizzard_Collections") then
					if not _G.CollectionsJournal.shadow then
						_G.CollectionsJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournal.shadow) end
					end
					if _G.CollectionsJournalTab1 and _G.CollectionsJournalTab1.backdrop and not _G.CollectionsJournalTab1.backdrop.shadow then
						_G.CollectionsJournalTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournalTab1.backdrop.shadow) end
					end
					if _G.CollectionsJournalTab2 and _G.CollectionsJournalTab2.backdrop and not _G.CollectionsJournalTab2.backdrop.shadow then
						_G.CollectionsJournalTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournalTab2.backdrop.shadow) end
					end
					if _G.CollectionsJournalTab3 and _G.CollectionsJournalTab3.backdrop and not _G.CollectionsJournalTab3.backdrop.shadow then
						_G.CollectionsJournalTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournalTab3.backdrop.shadow) end
					end
					if _G.CollectionsJournalTab4 and _G.CollectionsJournalTab4.backdrop and not _G.CollectionsJournalTab4.backdrop.shadow then
						_G.CollectionsJournalTab4.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournalTab4.backdrop.shadow) end
					end
					if _G.CollectionsJournalTab5 and _G.CollectionsJournalTab5.backdrop and not _G.CollectionsJournalTab5.backdrop.shadow then
						_G.CollectionsJournalTab5.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.CollectionsJournalTab5.backdrop.shadow) end
					end
					if not _G.ToyBox.shadow then
						_G.ToyBox:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ToyBox.shadow) end
					end
					if not _G.HeirloomsJournal.shadow then
						_G.HeirloomsJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.HeirloomsJournal.shadow) end
					end
					if not _G.PetJournal.shadow then
						_G.PetJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PetJournal.shadow) end
					end
					if not _G.WardrobeFrame.shadow then
						_G.WardrobeFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.WardrobeFrame.shadow) end
					end
				end
				if (arg == "Blizzard_PVPUI") or IsAddOnLoaded("Blizzard_PVPUI") then
					if not _G.PVPUIFrame.shadow then
						_G.PVPUIFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PVPUIFrame.shadow) end
					end
				end
				if (arg == "Blizzard_PlayerChoice") or IsAddOnLoaded("Blizzard_PlayerChoice") then
					if not _G.PlayerChoiceFrame.shadow then
						_G.PlayerChoiceFrame:CreateBackdrop('Transparent')
						_G.PlayerChoiceFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PlayerChoiceFrame.shadow) end
					end
				end
				if (arg == "Blizzard_VoidStorageUI") or IsAddOnLoaded("Blizzard_VoidStorageUI") then
					if not _G.VoidStorageFrame.shadow then
						_G.VoidStorageFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.VoidStorageFrame.shadow) end
					end
				end
				if (arg == "Blizzard_ChallengesUI") or IsAddOnLoaded("Blizzard_ChallengesUI") then
					if not _G.PVEFrame.shadow then
						_G.PVEFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.PVEFrame.shadow) end
					end
				end
				if (arg == "Blizzard_EncounterJournal") or IsAddOnLoaded("Blizzard_EncounterJournal") then
					if not _G.EncounterJournal.shadow then
						_G.EncounterJournal:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournal.shadow) end
					end
					if _G.EncounterJournalSuggestTab and _G.EncounterJournalSuggestTab.backdrop and not _G.EncounterJournalSuggestTab.backdrop.shadow then
						_G.EncounterJournalSuggestTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalSuggestTab.backdrop.shadow) end
					end
					if _G.EncounterJournalDungeonTab and _G.EncounterJournalDungeonTab.backdrop and not _G.EncounterJournalDungeonTab.backdrop.shadow then
						_G.EncounterJournalDungeonTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalDungeonTab.backdrop.shadow) end
					end
					if _G.EncounterJournalRaidTab and _G.EncounterJournalRaidTab.backdrop and not _G.EncounterJournalRaidTab.backdrop.shadow then
						_G.EncounterJournalRaidTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalRaidTab.backdrop.shadow) end
					end
					if _G.EncounterJournalLootJournalTab and _G.EncounterJournalLootJournalTab.backdrop and not _G.EncounterJournalLootJournalTab.backdrop.shadow then
						_G.EncounterJournalLootJournalTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalLootJournalTab.backdrop.shadow) end
					end
					if not _G.EncounterJournalEncounterFrameInfoOverviewTab.shadow then
						_G.EncounterJournalEncounterFrameInfoOverviewTab:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalEncounterFrameInfoOverviewTab.shadow) end
					end
					if not _G.EncounterJournalEncounterFrameInfoLootTab.shadow then
						_G.EncounterJournalEncounterFrameInfoLootTab:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalEncounterFrameInfoLootTab.shadow) end
					end
					if not _G.EncounterJournalEncounterFrameInfoBossTab.shadow then
						_G.EncounterJournalEncounterFrameInfoBossTab:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalEncounterFrameInfoBossTab.shadow) end
					end
					if not _G.EncounterJournalEncounterFrameInfoModelTab.shadow then
						_G.EncounterJournalEncounterFrameInfoModelTab:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalEncounterFrameInfoModelTab.shadow) end
					end
					if _G.EncounterJournalMonthlyActivitiesTab and _G.EncounterJournalMonthlyActivitiesTab.backdrop and not _G.EncounterJournalMonthlyActivitiesTab.backdrop.shadow then
						_G.EncounterJournalMonthlyActivitiesTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.EncounterJournalMonthlyActivitiesTab.backdrop.shadow) end
					end
				end
				if (arg == "Blizzard_WeeklyRewards") or IsAddOnLoaded("Blizzard_WeeklyRewards") then
					if not _G.WeeklyRewardsFrame.shadow then
						_G.WeeklyRewardsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.WeeklyRewardsFrame.shadow) end
					end
				end
			end
			if E.Retail then
				if (arg == "Blizzard_AuctionHouseUI") or IsAddOnLoaded("Blizzard_AuctionHouseUI") then
					if _G.AuctionHouseFrame then
						if _G.AuctionHouseFrame and not _G.AuctionHouseFrame.shadow then
							_G.AuctionHouseFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionHouseFrame.shadow) end
						end
						if _G.AuctionHouseFrameBuyTab.backdrop and not _G.AuctionHouseFrameBuyTab.backdrop.shadow then
							_G.AuctionHouseFrameBuyTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionHouseFrameBuyTab.backdrop.shadow) end
						end
						if _G.AuctionHouseFrameSellTab.backdrop and not _G.AuctionHouseFrameSellTab.backdrop.shadow then
							_G.AuctionHouseFrameSellTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionHouseFrameSellTab.backdrop.shadow) end
						end
						if _G.AuctionHouseFrameAuctionsTab.backdrop and not _G.AuctionHouseFrameAuctionsTab.backdrop.shadow then
							_G.AuctionHouseFrameAuctionsTab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionHouseFrameAuctionsTab.backdrop.shadow) end
						end
					end
				end
			elseif E.Wrath or E.Classic then
				if (arg == "Blizzard_AuctionUI") or IsAddOnLoaded("Blizzard_AuctionUI") then
					if _G.AuctionFrame and _G.AuctionFrame.backdrop and not _G.AuctionFrame.backdrop.shadow then
						_G.AuctionFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionFrame.backdrop.shadow) end
					end
					if _G.AuctionFrameTab1 and _G.AuctionFrameTab1.backdrop and not _G.AuctionFrameTab1.backdrop.shadow then
						_G.AuctionFrameTab1.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionFrameTab1.backdrop.shadow) end
					end
					if _G.AuctionFrameTab2 and _G.AuctionFrameTab2.backdrop and not _G.AuctionFrameTab2.backdrop.shadow then
						_G.AuctionFrameTab2.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionFrameTab2.backdrop.shadow) end
					end
					if _G.AuctionFrameTab3 and _G.AuctionFrameTab3.backdrop and not _G.AuctionFrameTab3.backdrop.shadow then
						_G.AuctionFrameTab3.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.AuctionFrameTab3.backdrop.shadow) end
					end
				end
			end
		end)

		local blizzardframes = {
			_G.GameMenuFrame,
			_G.DropDownList1,
			_G.DropDownList2,
			_G.ReadyCheckFrame,
			_G.StackSplitFrame,
			_G.ChatConfigFrame,
			_G.ShoppingTooltip1,
			_G.ShoppingTooltip2,
			_G.VideoOptionsFrame,
			_G.InterfaceOptionsFrame,
			_G.StaticPopup1, --seems like blizzard
			_G.StaticPopup2, --seems like blizzard
			_G.StaticPopup3, --seems like blizzard
			_G.StaticPopup4, --seems like blizzard
			_G.StaticPopup5, --seems like blizzard
			_G.CharacterFrameTab1.backdrop,
			_G.CharacterFrameTab2.backdrop,
			_G.CharacterFrameTab3.backdrop,
			_G.FriendsFrameTab1.backdrop,
			_G.FriendsFrameTab2.backdrop,
			_G.FriendsFrameTab3.backdrop,
			_G.FriendsFrameTab4.backdrop,
			_G.SpellBookFrameTabButton1.backdrop,
			_G.SpellBookFrameTabButton2.backdrop,
			_G.SpellBookFrameTabButton3.backdrop,
			_G.GossipFrame.backdrop,
			_G.BNToastFrame,
			_G.TimeAlertFrame,
			_G.ReportFrame,
			_G.SpellBookSkillLineTab1,
			_G.SpellBookSkillLineTab2,
			_G.SpellBookSkillLineTab3,
			_G.SpellBookSkillLineTab4,
			_G.SpellBookSkillLineTab5,
			_G.CliqueSpellTab,
			_G.EltruismClickCastingToggle,
			_G.TradeFrame,
			_G.AddonList,
			_G.VoidStorageFrame,
			_G.BonusRollFrame,
			_G.ItemRefTooltip,
			_G.CinematicFrameCloseDialog,
			_G.OrderHallCommandBar,
			_G.ProfessionsFrame,
			_G.GhostFrameContentsFrame,
			_G.SettingsPanel,
			_G.ExpansionLandingPage,
			_G.OrderHallMissionFrame,
			_G.LootHistoryFrame,
			_G.ExtraActionButton1,
			_G.ExtraActionButton2,
			_G.ExtraActionButton3,
			_G.ChatFrame1EditBox,
			_G.PVPReadyDialog,
			_G.TimerTrackerTimer1StatusBar,
			_G.TimerTrackerTimer2StatusBar,
			_G.TimerTrackerTimer3StatusBar,
			_G.RaidUtility_ShowButton,
			_G.RaidUtilityPanel,
			_G.RaidUtility_CloseButton,
			_G.EditModeManagerFrame,
			_G.PVPMatchScoreboard,
			_G.PVPMatchResults,
			_G.MajorFactionRenownFrame,
			_G.SubscriptionInterstitialFrame,
			--_G.ImmersionFrame.TalkBox,
			_G.ReadyStatus,
			_G.QuestFrame,
		}
		for _, frame in pairs(blizzardframes) do
			if frame and not frame.shadow then
				frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
			end
		end

		if _G.MovieFrame and _G.MovieFrame.CloseDialog then
			_G.MovieFrame.CloseDialog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.MovieFrame.CloseDialog.shadow) end
		end

		timermonitor:RegisterEvent("START_TIMER")
		timermonitor:SetScript("OnEvent", function()
			if _G.TimerTracker and _G.TimerTracker.timerList then
				for _, b in pairs(_G.TimerTracker.timerList) do
					if b.bar and not b.bar.shadow then
						b.bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(b.bar.shadow) end
					end
				end
			end
		end)

		if _G.LootHistoryFrame and _G.LootHistoryFrame.ResizeButton then
			_G.LootHistoryFrame.ResizeButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.LootHistoryFrame.ResizeButton.shadow) end
		end

		if _G.ProfessionsFrame and _G.ProfessionsFrame.TabSystem then
			for i = 1, _G.ProfessionsFrame.TabSystem:GetNumChildren() do
				local tab = select(i, _G.ProfessionsFrame.TabSystem:GetChildren())
				if tab and tab.backdrop then
					tab.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(tab.backdrop.shadow) end
				end
			end
			if _G.ProfessionsFrame.CraftingPage.CraftingOutputLog then
				_G.ProfessionsFrame.CraftingPage.CraftingOutputLog:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ProfessionsFrame.CraftingPage.CraftingOutputLog.shadow) end
			end
		end

		hooksecurefunc(_G.AlertFrame, "AddAlertFrame", function(_,frame)
			if frame and frame.backdrop and not frame.backdrop.shadow then
				frame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.backdrop.shadow) end
			end
		end)

		--elvui config shadows
		hooksecurefunc(E, "ToggleOptions", function()
			local frame = E:Config_GetWindow()
			if frame and not frame.shadow then
				frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
			end
		end)

		--statusreport
		hooksecurefunc(E, "ShowStatusReport", function()
			if _G["ElvUIStatusReport"] and not _G["ElvUIStatusReport"].shadow then
				_G["ElvUIStatusReport"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUIStatusReport"].shadow) end
			end
			if _G["ElvUIStatusPlugins"] and not _G["ElvUIStatusPlugins"].shadow then
				_G["ElvUIStatusPlugins"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUIStatusPlugins"].shadow) end
			end
		end)

		--mirror timer shadow
		if not E.Retail then
			for i = 1, _G.MIRRORTIMER_NUMTIMERS do
				local statusBar = _G['MirrorTimer'..i..'StatusBar']
				if statusBar then
					if not statusBar.shadow then
						statusBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(statusBar.shadow) end
					end
				end
			end
		else
			for i = 1, _G.MIRRORTIMER_NUMTIMERS do
				local statusBar = _G['MirrorTimer'..i]
				if statusBar then
					if not statusBar.shadow then
						statusBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(statusBar.shadow) end
					end
				end
			end
		end

		if E.private["general"]["minimap"]["enable"] and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) and E.db.ElvUI_EltreumUI.skins.shadow.minimap then

			local Minimapsizex, Minimapsizey = _G["Minimap"]:GetSize()
			MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
			MinimapShadow:SetParent(_G["Minimap"])
			if not (self.minimapIsSkinned) then
				MinimapShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"] ,"TOPRIGHT", 0, 0)
				MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", 0, 0)
				if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
					MinimapShadow:SetPoint("BOTTOMLEFT", _G["Minimap"] ,"BOTTOMLEFT", 0, 0)
				end
				if IsAddOnLoaded("ElvUI_SLE") and E.private["sle"]["minimap"]["rectangle"] == true then --Shadow and Light Rectangle Minimap
					if E.db.datatexts.panels.MinimapPanel.backdrop == true and E.db.datatexts.panels.MinimapPanel.enable == true then
						MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 0, 0)
						MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", 0, 0)
					elseif E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
						MinimapShadow:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 0, 0)
						MinimapShadow:SetPoint("BOTTOMLEFT", _G["Minimap"].backdrop ,"BOTTOMLEFT", 0, 0)
					end
				elseif IsAddOnLoaded("ElvUI_WindTools") and E.db["WT"]["maps"]["rectangleMinimap"]["enable"] == true then --Windtools rectangle minimap
					MinimapShadow:SetAllPoints(_G["Minimap"].backdrop)
					if E.db.datatexts.panels.MinimapPanel.backdrop == true and E.db.datatexts.panels.MinimapPanel.enable == true then
						if _G["MinimapPanel"] and not _G["MinimapPanel"].shadow then
							_G["MinimapPanel"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["MinimapPanel"].shadow) end
						end
					end
				end
				MinimapShadow:Show()
				if EnhancedShadows then EnhancedShadows:RegisterShadow(MinimapShadow.shadow) end
				self.minimapIsSkinned = true
			end
		end

		if _G.GameTooltip and not _G.GameTooltip.shadow then
			if E.private.tooltip.enable then
				_G.GameTooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GameTooltip.shadow) end
			end
		end

		if _G.LibDBIconTooltip and not _G.LibDBIconTooltip.shadow then
			if E.private.tooltip.enable then
				_G.LibDBIconTooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.LibDBIconTooltip.shadow) end
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
					--if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GameTooltip.shadow) end
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
				--if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.GameTooltip.shadow) end
			end)
		end

		------------------------------------------------------------------------------------------------------version specific
		if E.Retail then
			if IsAddOnLoaded("Rarity") then
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
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end

			--retail frames
			local retailframes = {
				_G.QueueStatusFrame,
				--_G.SplashFrame,
				_G.LFDRoleCheckPopup,
				_G.LFDReadyCheckPopup,
				_G.LFGListApplicationDialog,
				_G.LFGDungeonReadyDialog,
				_G.LFGDungeonReadyPopup,
				_G.LFGListInviteDialog,
				_G.PaperDollFrame,
				_G.GroupFinderFrame,
				_G.ZoneAbilityFrame,
				_G.ReputationFrame,
				_G.TokenFrame,
				_G.SpellBookFrame,
				_G.FriendsFrame,
				_G.MerchantFrame,
				_G.MerchantFrameTab1.backdrop,
				_G.MerchantFrameTab2.backdrop,
				_G.MailFrame,
				_G.ItemTextFrame,
				_G.OpenMailFrame,
				_G.MailFrameTab1.backdrop,
				_G.MailFrameTab2.backdrop,
				_G.HelpFrame.backdrop,
				_G.WorldMapFrame.backdrop,
				_G.WardrobeFrame, --weird
				_G.PVEFrame,
				_G.PVEFrameTab1.backdrop,
				_G.PVEFrameTab2.backdrop,
				_G.PVEFrameTab3.backdrop,
				_G.CollectionsJournal,
				_G.DressUpFrame,
				_G.DressUpFrame.OutfitDetailsPanel,
				_G.WeeklyRewardsFrame,
				_G.CovenantPreviewFrame,
				_G.PetStableFrame,
				_G.TaxiFrame,
				_G.TabardFrame,
				_G.LossOfControlFrame,
			}
			for _, frame in pairs(retailframes) do
				if frame and not frame.shadow then
					frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
			end

			--loss of control frame icon
			if _G.LossOfControlFrame and _G.LossOfControlFrame.Icon and _G.LossOfControlFrame.shadow then
				_G.LossOfControlFrame.shadow:ClearAllPoints()
				_G.LossOfControlFrame.shadow:SetPoint("TOPLEFT", _G.LossOfControlFrame.Icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
				_G.LossOfControlFrame.shadow:SetPoint("BOTTOMRIGHT", _G.LossOfControlFrame.Icon, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.LossOfControlFrame.shadow) end
			end

			--main minimize button easier here
			if _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton and not _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow then
				_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:CreateShadow()
				_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:ClearAllPoints()
				_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.tex, "TOPLEFT", -2,2)
				_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
				--if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.shadow) end
			end

			if E.db.ElvUI_EltreumUI.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then
				if _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ProfessionHeader and _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton and not _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow then
					_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton:CreateShadow()
					_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:ClearAllPoints()
					_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:SetPoint("TOPLEFT", _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.tex, "TOPLEFT", -2,2)
					_G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", _G.ObjectiveTrackerBlocksFrame.ProfessionHeader.MinimizeButton.tex, "BOTTOMRIGHT", 2,-2)
					--if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ObjectiveTrackerFrame.ProfessionHeader.MinimizeButton.shadow) end
				end
			end

			if E.private.actionbar.enable and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
				if not _G.BossButton.shadow then
					_G.BossButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.BossButton.shadow) end
				end
			end
		elseif E.Wrath or E.Classic then

			--totems
			local ElvUITotemFrames = {
			_G["ElvUF_PlayerTotem1"],
			_G["ElvUF_PlayerTotem2"],
			_G["ElvUF_PlayerTotem3"],
			_G["ElvUF_PlayerTotem4"],
			}
			for _, frame in pairs(ElvUITotemFrames) do
				if frame and frame.backdrop and not frame.backdrop.shadow then
					frame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
			end

			--raid pet
			for k = 1, 42 do
				local petunits = {_G["ElvUF_RaidpetGroup1UnitButton"..k]}
				for _, button in pairs(petunits) do
					if not button.shadow then
						button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
					end
				end
			end

			--tbc/classic frames
			local classicframes = {
				_G.HelpFrame,
				_G.QuestLogFrame.backdrop,
				_G.CharacterFrame.backdrop,
				_G.SpellBookFrame.backdrop,
				_G.FriendsFrame.backdrop,
				_G.MailFrame.backdrop,
				_G.OpenMailFrame.backdrop,
				_G.MailFrameTab1.backdrop,
				_G.MailFrameTab2.backdrop,
				_G.MerchantFrame.backdrop,
				_G.WorldMapFrame,
				--_G.WorldMapFrame.ScrollContainer,
				_G.CharacterFrameTab4.backdrop, --only in classic though
				_G.CharacterFrameTab5.backdrop, --only in classic though
				_G.FriendsFrameTab5.backdrop, --only in classic though
				_G.PetStableFrame.backdrop,
				_G.TaxiFrame.backdrop,
				_G.TabardFrame.backdrop,
				_G.ItemTextFrame.backdrop,
			}
			for _, frame in pairs(classicframes) do
				if frame and not frame.shadow then
					frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
			end

			--leatrix causing issues yet again
			if IsAddOnLoaded("Leatrix_Maps") then
				if LeaMapsDB["NoMapBorder"] == "On" then
					if _G.WorldMapFrame.shadow then
						_G.WorldMapFrame.shadow:Hide()
					end
				end
			end

			--wrath/tbc only frames
			if E.Wrath then
				local tbcframes = {
				_G.LFGParentFrame.backdrop,
				_G.LFGParentFrameTab1.backdrop,
				_G.LFGParentFrameTab2.backdrop,
				_G.QuestLogDetailFrame.backdrop,
				}
				for _, frame in pairs(tbcframes) do
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end

			--wrath only frames
			if E.Wrath and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
				if _G.LFGListingFrame.backdrop and not _G.LFGListingFrame.backdrop.shadow then
					_G.LFGListingFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.LFGListingFrame.backdrop.shadow) end
				end
				if _G.LFGBrowseFrame.backdrop and not _G.LFGBrowseFrame.backdrop.shadow then
					_G.LFGBrowseFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.LFGBrowseFrame.backdrop.shadow) end
				end

				--Shaman Totem things
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
							if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
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
								if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
							end
						end
					end)
				end
			end
		end
		------------------------------------------------------------------------------------------------------elvui frames
		local GeneralElvUIFrames = {
			_G["ElvLootFrame"],
			_G["ElvUI_ReputationBar"],
			_G["ElvUI_ExperienceBar"],
			_G["ElvUI_ThreatBar"],
			_G["ElvUIVendorGraysFrame"],
			_G["ElvUI_ContainerFrameContainerHolder"],
			_G["ElvUI_AltPowerBar"],
		}
		for _, frame in pairs(GeneralElvUIFrames) do
			if frame and not frame.shadow then
				frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
			end
		end

		--datatexts
		local DT = E:GetModule('DataTexts')
		if DT.tooltip then
			if not DT.tooltip.shadow then
				DT.tooltip:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(DT.tooltip.shadow) end
			end
		end

		--class totems
		for i = 1, MAX_TOTEMS do
			local classtotem = _G['ElvUI_TotemTrackerTotem'..i]
			if classtotem and not classtotem.shadow then
				classtotem:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(classtotem.shadow) end
			end
		end

		--action bars
		if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") and E.db.ElvUI_EltreumUI.skins.shadow.actionbars and not IsAddOnLoaded("Masque") then
			--elvui action bars
			for i = 1, 10 do
				for k = 1, 12 do
					local slots = {_G["ElvUI_Bar"..i..'Button'..k]}
					for _, button in pairs(slots) do
						if not button.shadow and not (E.db.ElvUI_EltreumUI.borders.borders and E.db["ElvUI_EltreumUI"]["borders"]["bar"..i.."borders"]) then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
						end
					end
				end
			end

			--pet bars
			for i = 1, 12 do
				local button = _G["PetActionButton"..i]
				if not button then
					break
				else
					if not button.shadow and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.petactionborders) then
						button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
					end
				end
			end
			if _G["ElvUI_BarPet"].backdrop and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.petactionborders) then
				if not _G["ElvUI_BarPet"].backdrop.shadow then
					_G["ElvUI_BarPet"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUI_BarPet"].backdrop.shadow) end
				end
			end

			--stances
			if not _G["EltruismStanceBorder1"] and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.stanceborders) then
				for i = 1, 12 do
					local button = _G["ElvUI_StanceBarButton"..i]
					if not button then
						break
					else
						if not button.shadow then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
						end
					end
				end
			end

		end

		--microbar shadow
		if E.db.actionbar.microbar.enabled == true then
			if E.db.actionbar.microbar.backdrop == true then
				if _G.ElvUI_MicroBar and _G.ElvUI_MicroBar.backdrop and not _G.ElvUI_MicroBar.backdrop.shadow then
					_G.ElvUI_MicroBar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.ElvUI_MicroBar.backdrop.shadow) end
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
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end
		end

		--unitframes
		if E.private.unitframe.enable then
			if E.Retail or E.Wrath then
				if not _G["ElvUF_Focus_HealthBar"].shadow and not (E.db.ElvUI_EltreumUI.borders.focusborder and E.db.ElvUI_EltreumUI.borders.borders)then
					_G["ElvUF_Focus_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Focus_HealthBar"].shadow) end
				end
				if not _G["ElvUF_Focus_PowerBar"].shadow and not (E.db.ElvUI_EltreumUI.borders.focusborder and E.db.ElvUI_EltreumUI.borders.borders)then
					_G["ElvUF_Focus_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Focus_PowerBar"].shadow) end
				end
				if not _G["ElvUF_FocusTarget_HealthBar"].shadow then
					_G["ElvUF_FocusTarget_HealthBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_FocusTarget_HealthBar"].shadow) end
				end
				if not _G["ElvUF_FocusTarget_PowerBar"].shadow then
					_G["ElvUF_FocusTarget_PowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_FocusTarget_PowerBar"].shadow) end
				end
				if E.db.ElvUI_EltreumUI.unitframes.infopanelontop then
					if E.db["unitframe"]["units"]["focus"]["infoPanel"]["enable"] then
						if _G["ElvUF_Focus_HealthBar"].shadow then
							_G["ElvUF_Focus_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Focus_PowerBar"].shadow then
							_G["ElvUF_Focus_PowerBar"].shadow:Hide()
						end
						if not _G["ElvUF_Focus"].shadow then
							_G["ElvUF_Focus"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Focus"].shadow) end
						end
						if _G["ElvUF_Focus"].shadow then
							_G["ElvUF_Focus"].shadow:ClearAllPoints()
							_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Focus_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Focus_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db["unitframe"]["units"]["focus"]["power"]["enable"] then
								if E.db["unitframe"]["units"]["focus"]["power"]["width"] == "inset" then
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Focus_PowerBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									_G["ElvUF_Focus"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Focus_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Focus"].shadow) end
						end
					end
					if E.db["unitframe"]["units"]["focustarget"]["infoPanel"]["enable"] then
						if _G["ElvUF_FocusTarget_HealthBar"].shadow then
							_G["ElvUF_FocusTarget_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_FocusTarget_PowerBar"].shadow then
							_G["ElvUF_FocusTarget_PowerBar"].shadow:Hide()
						end
						if not _G["ElvUF_FocusTarget"].shadow then
							_G["ElvUF_FocusTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_FocusTarget"].shadow) end
						end
						if _G["ElvUF_FocusTarget"].shadow then
							_G["ElvUF_FocusTarget"].shadow:ClearAllPoints()
							_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_FocusTarget_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_FocusTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_FocusTarget_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db["unitframe"]["units"]["focustarget"]["power"]["width"] == "inset" then
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							else
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_FocusTarget_PowerBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_FocusTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_FocusTarget_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_FocusTarget"].shadow) end
						end
					end
				end
			end

			local elvuiframes = {
				_G["ElvUF_TargetTarget_HealthBar"],
				_G["ElvUF_TargetTargetTarget_HealthBar"],
				_G["ElvUF_Target_HealthBar"],
				_G["ElvUF_Pet_HealthBar"],
				_G["ElvUF_Player_HealthBar"],
				_G["ElvUF_Arena1"],
				_G["ElvUF_Arena2"],
				_G["ElvUF_Arena3"],
				_G["ElvUF_Arena4"],
				_G["ElvUF_Arena5"],
				_G["ElvUF_Player_CastBar"],
				_G["ElvUF_Target_CastBar"],
				_G["ElvUF_Focus_CastBar"],
			}
			for _, frame in pairs(elvuiframes) do
				if frame then
					if not frame.shadow then
						if not E.db.ElvUI_EltreumUI.borders.borders then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
						end
					elseif frame.shadow then
						if E.db.ElvUI_EltreumUI.borders.borders then
							frame.shadow:Hide()
						else
							frame.shadow:Show()
						end
					end
				end
			end

			local elvuiframeswithborders = {
				_G["ElvUF_TargetTarget_PowerBar"],
				_G["ElvUF_TargetTargetTarget_PowerBar"],
				_G["ElvUF_Target_PowerBar"],
				_G["ElvUF_Player_PowerBar"],
				_G["ElvUF_Player_Stagger"],
			}
			for _, frame in pairs(elvuiframeswithborders) do
				if frame then
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end

			if E.db["unitframe"]["units"]["player"]["portrait"]["enable"] == true and E.db["unitframe"]["units"]["player"]["portrait"]["overlay"] == false then
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					if not (E.db.ElvUI_EltreumUI.borders.playerborder and E.db.ElvUI_EltreumUI.borders.borders) then
						_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						if E.db["unitframe"]["units"]["player"]["orientation"] == "RIGHT" then
							_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						else
							_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if E.db["unitframe"]["units"]["player"]["power"]["width"] ~= "spaced" then
							if _G["ElvUF_Player_PowerBar"].shadow then
								_G["ElvUF_Player_PowerBar"].shadow:Hide()
							end
						end
						if E.Retail then
							if _G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"].shadow then
								_G["ElvUF_Player_Stagger"].shadow:Hide()
							end
						end
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
					end
				end
				--[[if _G["ElvUF_Player"].Portrait.backdrop and not _G["ElvUF_Player"].Portrait.backdrop.shadow then
					if (not E.db.ElvUI_EltreumUI.borders.playerborder) then
						_G["ElvUF_Player"].Portrait.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end]]
			end

			if E.db["unitframe"]["units"]["target"]["portrait"]["enable"] == true and E.db["unitframe"]["units"]["target"]["portrait"]["overlay"] == false then
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					if not (E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.ElvUI_EltreumUI.borders.borders) then
						_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						if E.db["unitframe"]["units"]["target"]["orientation"] == "LEFT" then
							_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						else
							_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if E.db["unitframe"]["units"]["target"]["power"]["width"] ~= "spaced" then
							if _G["ElvUF_Target_PowerBar"].shadow then
								_G["ElvUF_Target_PowerBar"].shadow:Hide()
							end
						end
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
					end
				end
				--[[if _G["ElvUF_Target"].Portrait.backdrop and not _G["ElvUF_Target"].Portrait.backdrop.shadow then
					if (not E.db.ElvUI_EltreumUI.borders.targetborder) then
						_G["ElvUF_Target"].Portrait.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end]]
			end

			--player castbar
			if E.db.unitframe.units.player.castbar.overlayOnFrame == "None" and not (E.db.ElvUI_EltreumUI.borders.playercastborder and E.db.ElvUI_EltreumUI.borders.borders) and E.db.unitframe.units.player.castbar.icon then
				if _G["ElvUF_Player_CastBar"].shadow then
					if E.db["unitframe"]["units"]["player"]["orientation"] == "RIGHT" then
						if not E.db.unitframe.units.player.castbar.iconAttached then
							if E.db["unitframe"]["units"]["player"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon.bg, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon.bg, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.player.castbar.iconAttached then
							_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					else
						if not E.db.unitframe.units.player.castbar.iconAttached then
							if E.db["unitframe"]["units"]["player"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.player.castbar.iconAttached then
							_G["ElvUF_Player_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Player_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Player_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Player_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player_CastBar"].shadow) end
				end
			end

			--target castbar
			if E.db.unitframe.units.target.castbar.overlayOnFrame == "None" and not (E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.ElvUI_EltreumUI.borders.borders) and E.db.unitframe.units.target.castbar.icon then
				if _G["ElvUF_Target_CastBar"].shadow then
					if E.db["unitframe"]["units"]["target"]["orientation"] == "RIGHT" then
						if not E.db.unitframe.units.target.castbar.iconAttached then
							if E.db["unitframe"]["units"]["target"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.target.castbar.iconAttached then
							_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					else
						if not E.db.unitframe.units.target.castbar.iconAttached then
							if E.db["unitframe"]["units"]["target"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.target.castbar.iconAttached then
							_G["ElvUF_Target_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Target_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Target_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Target_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target_CastBar"].shadow) end
				end
			end

			--focus castbar
			if E.db.unitframe.units.focus.castbar.overlayOnFrame == "None" and E.db.unitframe.units.focus.castbar.icon and E.db.unitframe.units.focus.enable then
				if _G["ElvUF_Focus_CastBar"] and _G["ElvUF_Focus_CastBar"].shadow then
					if E.db["unitframe"]["units"]["focus"]["orientation"] == "RIGHT" then
						if not E.db.unitframe.units.focus.castbar.iconAttached then
							if E.db["unitframe"]["units"]["focus"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon.bg, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon.bg, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.focus.castbar.iconAttached then
							_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					else
						if not E.db.unitframe.units.focus.castbar.iconAttached then
							if E.db["unitframe"]["units"]["focus"]["castbar"]["iconAttachedTo"] == "Castbar" then
								_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon.bg, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon.bg, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						elseif E.db.unitframe.units.focus.castbar.iconAttached then
							_G["ElvUF_Focus_CastBar"].shadow:ClearAllPoints()
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPLEFT",_G["ElvUF_Focus_CastBar"].Icon, "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMLEFT",_G["ElvUF_Focus_CastBar"].Icon, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("TOPRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Focus_CastBar"].shadow:SetPoint("BOTTOMRIGHT",_G["ElvUF_Focus_CastBar"].backdrop, "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Focus_CastBar"].shadow) end
				end
			end

			--party
			for i = 1, 5 do
				local partymembers = {_G["ElvUF_PartyGroup1UnitButton"..i]}
				for _, frame in pairs(partymembers) do
					if not frame.shadow then
						if not (E.db.ElvUI_EltreumUI.borders.partyborders and E.db.ElvUI_EltreumUI.borders.borders) then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db["unitframe"]["units"]["party"]["power"]["enable"] and E.db["unitframe"]["units"]["party"]["power"]["width"] == "spaced" then
								frame.shadow:ClearAllPoints()
								frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("TOPLEFT", frame.Health,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("TOPRIGHT", frame.Health,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if not frame.Power.shadow then
									frame.Power:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.Power.shadow) end
								end
							end
							if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
								frame.shadow:ClearAllPoints()
								frame.shadow:SetPoint("BOTTOMLEFT", frame.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("BOTTOMRIGHT", frame.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								if E.db["unitframe"]["units"]["party"]["power"]["enable"] and E.db["unitframe"]["units"]["party"]["power"]["width"] == "spaced" then
									frame.shadow:ClearAllPoints()
									frame.shadow:SetPoint("BOTTOMLEFT", frame.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("BOTTOMRIGHT", frame.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPLEFT", frame.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
									frame.shadow:SetPoint("TOPRIGHT", frame.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								end
							end
							if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
						end
					end
				end
			end

			--party pets
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
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
			end

			--raidpets
			for i =1, 40 do
				local RaidPetElvUIFrames = {_G["ElvUF_RaidpetGroup1UnitButton"..i]}
				for _, frame in pairs(RaidPetElvUIFrames) do
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end

			--boss
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
							if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
						end
					end
					--[[for _, button in pairs(bossmembers) do
						if not button.shadow then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end]]
				end
			end

			--tank targets
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
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
					--[[for _, button in pairs(tankmembers) do
						if not button.shadow then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end]]
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
						if not button.shadow and (E.db["unitframe"]["units"]["player"]["classbar"]["fill"] == "spaced" or E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] == true) then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
						end
					end
				end
			end

			--AdditionalPowerBar
			if E.myclass == 'DRUID' or E.myclass == 'SHAMAN' or E.myclass == 'PRIEST' then
				local additionalpowerbar = _G["ElvUF_Player_AdditionalPowerBar"]
				if additionalpowerbar ~= nil then
					if not _G["ElvUF_Player_AdditionalPowerBar"].shadow then
						_G["ElvUF_Player_AdditionalPowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player_AdditionalPowerBar"].shadow) end
					end
				end
			end

			--classpower
			if not (E.myclass == 'DEATHKNIGHT') then
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
							if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
						end
					end
				end
			end
		end

		--handle non spaced power and classpower
		if E.db["unitframe"]["units"]["target"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["target"]["power"]["enable"] then
			if not E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] then
				if _G["ElvUF_Target_PowerBar"] and _G["ElvUF_Target_PowerBar"].shadow then
					_G["ElvUF_Target_PowerBar"].shadow:Hide()
				end
				if _G["ElvUF_Target_HealthBar"] and _G["ElvUF_Target_HealthBar"].shadow then
					_G["ElvUF_Target_HealthBar"].shadow:Hide()
				end
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
				end
				if E.db["unitframe"]["units"]["target"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["target"]["power"]["width"] == "fill" then
					if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
					end
				else
					if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
					end
				end
			else
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
				end
				if E.db["unitframe"]["units"]["target"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["target"]["power"]["width"] == "fill" then
					if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
					end
				else
					if _G["ElvUF_Target"] and _G["ElvUF_Target"].shadow then
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
					end
				end
			end
		end
		if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] then
			if not E.db["unitframe"]["units"]["targettarget"]["power"]["detachFromFrame"] then
				if _G["ElvUF_TargetTarget_PowerBar"] and _G["ElvUF_TargetTarget_PowerBar"].shadow then
					_G["ElvUF_TargetTarget_PowerBar"].shadow:Hide()
				end
				if _G["ElvUF_TargetTarget_HealthBar"] and _G["ElvUF_TargetTarget_HealthBar"].shadow then
					_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
				end
				if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
					_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
				end
				if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "fill" then
					if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
						_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
						_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
					end
				else
					if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
						_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
						_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
					end
				end
			else
				if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
					_G["ElvUF_TargetTarget"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
				end
				if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "fill" then
					if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
						_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
						_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
					end
				else
					if _G["ElvUF_TargetTarget"] and _G["ElvUF_TargetTarget"].shadow then
						_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
						_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
					end
				end
			end
		end
		if not E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] then
			if _G["ElvUF_TargetTarget_HealthBar"] and _G["ElvUF_TargetTarget_HealthBar"].shadow then
				_G["ElvUF_TargetTarget_HealthBar"].shadow:Show()
			end
		end
		if E.db["unitframe"]["units"]["player"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["player"]["power"]["enable"] then
			if not E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] then
				if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
					_G["ElvUF_Player_PowerBar"].shadow:Hide()
				end
				if _G["ElvUF_Player_HealthBar"] and _G["ElvUF_Player_HealthBar"].shadow then
					_G["ElvUF_Player_HealthBar"].shadow:Hide()
				end
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
				end
				if E.db["unitframe"]["units"]["player"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["player"]["power"]["width"] == "fill" then
					if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if _G["ElvUF_Player_ClassBar"]:IsShown() then
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db["unitframe"]["units"]["player"]["classbar"]["height"]/2))
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
					end
				else
					if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
					end
				end
			else
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
				end
				if E.db["unitframe"]["units"]["player"]["power"]["width"] == "inset" or E.db["unitframe"]["units"]["player"]["power"]["width"] == "fill" then
					if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if _G["ElvUF_Player_ClassBar"]:IsShown() or _G["ElvUF_Player_AdditionalPowerBar"]:IsShown() or _G["ElvUF_Player_Stagger"]:IsShown() or (_G.ElvUF_Player.Totems and _G.ElvUF_Player.Totems:IsVisible()) or (_G.ElvUF_Player_Runes and _G.ElvUF_Player_Runes:IsVisible()) then
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length, (E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db["unitframe"]["units"]["player"]["classbar"]["height"]/2)))
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
					end
				else
					if _G["ElvUF_Player"] and _G["ElvUF_Player"].shadow then
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						if _G["ElvUF_Player_ClassBar"]:IsShown() or _G["ElvUF_Player_AdditionalPowerBar"]:IsShown() or _G["ElvUF_Player_Stagger"]:IsShown() or (_G.ElvUF_Player.Totems and _G.ElvUF_Player.Totems:IsVisible()) or (_G.ElvUF_Player_Runes and _G.ElvUF_Player_Runes:IsVisible()) then
							_G["ElvUF_Player"].shadow:ClearAllPoints()
							_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"], "TOPLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length, (E.db.ElvUI_EltreumUI.skins.shadow.length - (E.db["unitframe"]["units"]["player"]["classbar"]["height"]/2)))
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"], "BOTTOMRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
					end
				end
			end
		end
		if E.db["unitframe"]["units"]["player"]["classbar"]["fill"] ~= "spaced" and not E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] and E.db["unitframe"]["units"]["player"]["power"]["enable"] then
			if _G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"].shadow then
				_G["ElvUF_Player_Stagger"].shadow:Hide()
			end
			if _G["ElvUF_Player_AdditionalPowerBar"] and _G["ElvUF_Player_AdditionalPowerBar"].shadow then
				_G["ElvUF_Player_AdditionalPowerBar"].shadow:Hide()
			end
		end

		--bags
		if E.private.bags.enable then
			if _G.ElvUI_ContainerFrame and not _G.ElvUI_ContainerFrame.shadow then
				_G["ElvUI_ContainerFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUI_ContainerFrame"].shadow) end
			end
			if _G.ElvUI_BankContainerFrame and not _G.ElvUI_BankContainerFrame.shadow then
				_G["ElvUI_BankContainerFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUI_BankContainerFrame"].shadow) end
			end
		end

		--elvui popup
		for i = 1, 5 do
			local ElvUI_StaticPopups = {_G["ElvUI_StaticPopup"..i]}
			for _, button in pairs(ElvUI_StaticPopups) do
				if not button.shadow then
					button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
				end
			end
		end

		--chat
		if E.db.ElvUI_EltreumUI.skins.shadow.chat and not (E.db.ElvUI_EltreumUI.borders.chatborder and E.db.ElvUI_EltreumUI.borders.borders) then
			local rightsizex, rightsizey = _G["RightChatMover"]:GetSize()
			RightChatShadow:SetSize(rightsizex, rightsizey)
			RightChatShadow:SetParent(_G["RightChatPanel"].backdrop)
			local leftsizex, leftsizey = _G["LeftChatMover"]:GetSize()
			LeftChatShadow:SetSize(leftsizex, leftsizey)
			LeftChatShadow:SetParent(_G["LeftChatPanel"].backdrop)

			if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
				if _G["RightChatPanel"] and _G["RightChatPanel"].backdrop and not _G["RightChatPanel"].backdrop.shadow then
					_G["RightChatPanel"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(RightChatShadow.shadow) end
				end
				if _G["LeftChatPanel"] and _G["LeftChatPanel"].backdrop and not _G["LeftChatPanel"].backdrop.shadow then
					_G["LeftChatPanel"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(LeftChatShadow.shadow) end
				end
			else
				if not (self.RightChatIsSkinned) then
					RightChatShadow.shadow = RightChatShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					RightChatShadow:SetPoint("TOPRIGHT", _G["RightChatPanel"] ,"TOPRIGHT", 0, 0)
					if E.db["datatexts"]["panels"]["RightChatDataPanel"]["enable"] then
						RightChatShadow:SetPoint("BOTTOMLEFT", _G["RightChatDataPanel"] ,"BOTTOMLEFT", 0, 0)
					else
						RightChatShadow:SetPoint("BOTTOMLEFT", _G["RightChatPanel"] ,"BOTTOMLEFT", 0, 0)
					end
					RightChatShadow:Show()
					if EnhancedShadows then EnhancedShadows:RegisterShadow(RightChatShadow.shadow) end
					self.RightChatIsSkinned = true
				end
				if not (self.LeftChatIsSkinned) then
					LeftChatShadow.shadow = LeftChatShadow:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					LeftChatShadow:SetPoint("TOPLEFT", _G["LeftChatPanel"] ,"TOPLEFT", 0, 0)
					if E.db["datatexts"]["panels"]["LeftChatDataPanel"]["enable"] then
						LeftChatShadow:SetPoint("BOTTOMRIGHT", _G["LeftChatDataPanel"] ,"BOTTOMRIGHT", 0, 0)
					else
						LeftChatShadow:SetPoint("BOTTOMRIGHT", _G["LeftChatPanel"] ,"BOTTOMRIGHT", 0, 0)
					end
					LeftChatShadow:Show()
					if EnhancedShadows then EnhancedShadows:RegisterShadow(LeftChatShadow.shadow) end
					self.LeftChatIsSkinned = true
				end
			end
			if E.db["chat"]["panelBackdrop"] == "LEFT" then
				RightChatShadow:Hide()
			elseif E.db["chat"]["panelBackdrop"] == "RIGHT" then
				LeftChatShadow:Hide()
			elseif E.db["chat"]["panelBackdrop"] == "HIDEBOTH" then
				LeftChatShadow:Hide()
				RightChatShadow:Hide()
			end
		end

		--info panel on top
		if E.db.ElvUI_EltreumUI.unitframes.infopanelontop then
			if E.db["unitframe"]["units"]["player"]["infoPanel"]["enable"] then
				if not _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"].shadow:Show()
					_G["ElvUF_Player"].shadow:ClearAllPoints()
					_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					local benikdettached = false
					if IsAddOnLoaded("ElvUI_BenikUI") then
						benikdettached = E.db.benikui.unitframes.player.detachPortrait
					end
					if E.db["unitframe"]["units"]["player"]["portrait"]["enable"] and E.db["unitframe"]["units"]["player"]["portrait"]["style"] ~= "3D" and not benikdettached then
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					if E.db["unitframe"]["units"]["player"]["power"]["enable"] then
						if E.db["unitframe"]["units"]["player"]["power"]["width"] == "fill" then
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if (E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] or E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"]) then
						if E.db["unitframe"]["units"]["player"]["infoPanel"]["enable"] then
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						else
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player"].shadow) end
				end
			end
			if E.db["unitframe"]["units"]["target"]["infoPanel"]["enable"] then
				if not _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"].shadow:ClearAllPoints()
					_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					local benikdettachedtarget = false
					if IsAddOnLoaded("ElvUI_BenikUI") then
						benikdettachedtarget = E.db.benikui.unitframes.target.detachPortrait
					end
					if E.db["unitframe"]["units"]["target"]["portrait"]["enable"] and E.db["unitframe"]["units"]["target"]["portrait"]["style"] ~= "3D" and not benikdettachedtarget then
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target"].Portrait,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"].Portrait,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					if E.db["unitframe"]["units"]["target"]["power"]["enable"] then
						if E.db["unitframe"]["units"]["target"]["power"]["width"] == "fill" then
							_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] then
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Target"].shadow) end
				end
			end

			if E.db["unitframe"]["units"]["targettarget"]["infoPanel"]["enable"] then
				if _G["ElvUF_TargetTarget"].shadow then
					_G["ElvUF_TargetTarget"].shadow:ClearAllPoints()
					_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_InfoPanel"],"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_TargetTarget_InfoPanel"],"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					if E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] then
						if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "inset" then
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_HealthBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						else
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_TargetTarget_PowerBar"] ,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_TargetTarget"].shadow) end
				end
			end

			if E.db["unitframe"]["units"]["pet"]["infoPanel"]["enable"] then
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
					if E.db["unitframe"]["units"]["pet"]["portrait"]["enable"] then
						_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet"].Portrait,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						_G["ElvUF_Pet"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Pet"].Portrait,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
					if E.db["unitframe"]["units"]["pet"]["power"]["enable"] then
						if E.db["unitframe"]["units"]["pet"]["power"]["width"] == "inset" then
							_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_HealthBar"],"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						else
							_G["ElvUF_Pet"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_PowerBar"] ,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Pet"].shadow) end
				end
			end
		end

		--[[if E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] then
			if _G["ElvUF_Player_ClassBar"].shadow then
				_G["ElvUF_Player_ClassBar"].shadow:Show()
			else
				_G["ElvUF_Player_ClassBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvUF_Player_ClassBar"].shadow) end
			end
		end]]
		if E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] then
			if _G["ElvUF_Player_PowerBar"].shadow then
				_G["ElvUF_Player_PowerBar"].shadow:Show()
			end
		end
		if E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] then
			if _G["ElvUF_Target_PowerBar"].shadow then
				_G["ElvUF_Target_PowerBar"].shadow:Show()
			end
		end

		------------------------------------------------------------------------------------------------------end of elvui frames
		if IsAddOnLoaded('ProjectAzilroka') then
			if _G.stAMFrame and not _G.stAMFrame.shadow then
				_G.stAMFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.stAMFrame.shadow) end
			end

			if _G.stAMProfileMenu and not _G.stAMProfileMenu.shadow then
				_G.stAMProfileMenu:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.stAMProfileMenu.shadow) end
			end

			if _G.SquareMinimapButtonBar and not _G.SquareMinimapButtonBar.shadow then
				_G.SquareMinimapButtonBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.SquareMinimapButtonBar.shadow) end
			end
		end
	end
end

function ElvUI_EltreumUI:RaidShadows()
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
		--raid
		for i = 1, 3 do
			for k = 1, 8 do
				for l = 1, 5 do
					local slots = {_G["ElvUF_Raid"..i..'Group'..k..'UnitButton'..l]}
					for _, button in pairs(slots) do
						if button and not button.shadow then
							button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if E.db.ElvUI_EltreumUI.unitframes.infopanelontop and E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
								button.shadow:ClearAllPoints()
								--[[if button.Power then
									button.shadow:SetPoint("BOTTOMLEFT", button.Power,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									button.shadow:SetPoint("BOTTOMRIGHT", button.Power,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								else
									button.shadow:SetPoint("BOTTOMLEFT", button.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
									button.shadow:SetPoint("BOTTOMRIGHT", button.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								end]]
								button.shadow:SetPoint("BOTTOMLEFT", button.Health,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								button.shadow:SetPoint("BOTTOMRIGHT", button.Health,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								button.shadow:SetPoint("TOPLEFT", button.InfoPanel,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								button.shadow:SetPoint("TOPRIGHT", button.InfoPanel,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
							button.shadow:SetParent(button)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
						end
					end
				end
			end
		end

		--tanks
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
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
				--[[for _, button in pairs(tankmembers) do
					if not button.shadow then
						button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end]]
			end
		end

		--assists
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
					if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
				end
				--[[for _, button in pairs(assistmembers) do
					if not button.shadow then
						button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end]]
			end
		end

	end
end

--benik's version
function ElvUI_EltreumUI:NameplateShadows(nameplate)
	if E.private.nameplates.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable then
		if E.db.ElvUI_EltreumUI.skins.shadow.nameplates then
			if nameplate.Health.backdrop and not nameplate.Health.backdrop.shadow then
				nameplate.Health.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(nameplate.Health.backdrop.shadow) end
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
			if nameplate.Power.backdrop and not nameplate.Power.backdrop.shadow then
				nameplate.Power.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(nameplate.Power.backdrop.shadow) end
			end
			if _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"].shadow then
				_G["ElvNP_TargetClassPowerClassPower"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ElvNP_TargetClassPowerClassPower"].shadow) end
			end
			if _G["EltruismPowerBar"] and not _G["EltruismPowerBar"].shadow then
				_G["EltruismPowerBar"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["EltruismPowerBar"].shadow) end
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.npcastbar then
			if nameplate.Castbar.backdrop and not nameplate.Castbar.backdrop.shadow then
				nameplate.Castbar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(nameplate.Castbar.backdrop.shadow) end
			end

			if nameplate.Castbar.Button and not nameplate.Castbar.Button.shadow then
				nameplate.Castbar.Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(nameplate.Castbar.Button.shadow) end
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.npportraits then
			if nameplate.Portrait.backdrop and not nameplate.Portrait.backdrop.shadow then
				nameplate.Portrait.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(nameplate.Portrait.backdrop.shadow) end
			end
		end
	end
end
hooksecurefunc(NP, 'StylePlate', ElvUI_EltreumUI.NameplateShadows) --nameplate shadows

function ElvUI_EltreumUI:Construct_AuraIcon(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.npauras then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
		end
	end
end
hooksecurefunc(NP, 'Construct_AuraIcon', ElvUI_EltreumUI.Construct_AuraIcon) --nameplate buffs/debuffs shadows

function ElvUI_EltreumUI:AuraShadows(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborder) and not IsAddOnLoaded("Masque") then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
		end
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraShadows) --aura (minimap) shadows

function ElvUI_EltreumUI:UFAuraShadows(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.ufaura and not IsAddOnLoaded("Masque") then
		if button and not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(button.shadow) end
		end
	end
end
hooksecurefunc(UF, 'Construct_AuraIcon', ElvUI_EltreumUI.UFAuraShadows) --uf aura shadows

--from elvui chat bubbles
local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 0.1
local M = E:GetModule('Misc')
function ElvUI_EltreumUI:ChatBubblesShadows()
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not self.ChatShadowsHooked then
		M.BubbleFrame:HookScript("OnUpdate",function(_,elapsed)
			TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
			if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
				TimeSinceLastUpdate = 0
				for _, frame in pairs(C_ChatBubbles.GetAllChatBubbles()) do
					local holder = frame:GetChildren()
					if holder and not holder:IsForbidden() and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				end
			end
		end)
		self.ChatShadowsHooked = true
	end
end
hooksecurefunc(M, "LoadChatBubbles", ElvUI_EltreumUI.ChatBubblesShadows)
