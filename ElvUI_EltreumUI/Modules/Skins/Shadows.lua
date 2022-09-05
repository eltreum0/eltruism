local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local A = E:GetModule('Auras')
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local IsInRaid = _G.IsInRaid
local hooksecurefunc = _G.hooksecurefunc
local PlayerCastbar = CreateFrame("Frame", "EltruismPlayerCastBarShadowFrame")
local TargetCastbar = CreateFrame("Frame", "EltruismTargetCastBarShadowFrame")

--Frame Shadows, turns out ElvUI includes the function
function ElvUI_EltreumUI:Shadows()
	if E.db.ElvUI_EltreumUI.skins.shadow.enable then
		------------------------------------------------------------------------------------------------------blizzard frames

		local EltruismBlizzShadows = CreateFrame("Frame")
		EltruismBlizzShadows:RegisterEvent("ADDON_LOADED")
		EltruismBlizzShadows:SetScript("OnEvent", function(_, _, arg)
			if (arg == "Blizzard_MacroUI") then
				_G.MacroFrame:HookScript("OnShow", function()
					if E.Retail or E.Wrath or E.TBC then
						if not _G.MacroFrame.shadow then
							_G.MacroFrame:CreateShadow()
						end
					elseif E.Classic then
						if _G.MacroFrame and _G.MacroFrame.backdrop and not _G.MacroFrame.backdrop.shadow then
							_G.MacroFrame.backdrop:CreateShadow()
						end
					end
				end)
			end
			if (arg == "Blizzard_BindingUI") then
				_G.KeyBindingFrame:HookScript("OnShow", function()
					if not _G.KeyBindingFrame.shadow then
						_G.KeyBindingFrame:CreateShadow()
					end
				end)
			end
			if (arg == "Blizzard_InspectUI") then
				_G.InspectFrame:HookScript("OnShow", function()
					if E.Wrath or E.TBC or E.Classic then
						if _G.InspectFrame and _G.InspectFrame.backdrop and not _G.InspectFrame.backdrop.shadow then
							_G.InspectFrame.backdrop:CreateShadow()
						end
					elseif E.Retail then
						if _G.InspectFrame and not _G.InspectFrame.shadow then
							_G.InspectFrame:CreateShadow()
						end
					end
				end)
			end
			if E.Retail then
				if (arg == "Blizzard_AuctionHouseUI") then
					_G.AuctionHouseFrame:HookScript("OnShow", function()
						if _G.AuctionHouseFrame and not _G.AuctionHouseFrame.shadow then
							_G.AuctionHouseFrame:CreateShadow()
						end
					end)
				end
			elseif E.Wrath or E.TBC or E.Classic then
				if (arg == "Blizzard_AuctionUI") then
					_G.AuctionFrame:HookScript("OnShow", function()
						if _G.AuctionFrame and _G.AuctionFrame.backdrop and not _G.AuctionFrame.backdrop.shadow then
							_G.AuctionFrame.backdrop:CreateShadow()
						end
					end)
				end
			end
		end)

		local blizzardframes = {
			_G.GameMenuFrame,
			_G.DropDownList1,
			_G.DropDownList2,
			_G.GameTooltip,
			_G.ReadyCheckFrame,
			_G.StackSplitFrame,
			_G.ChatConfigFrame,
			_G.ShoppingTooltip1,
			_G.ShoppingTooltip2,
			_G.VideoOptionsFrame,
			_G.InterfaceOptionsFrame,
			_G.StaticPopup1, --seems like blizzard
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

		if E.private["general"]["minimap"]["enable"] ~= false and not E.db.ElvUI_EltreumUI.borders.borders then
			local MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
			local Minimapsizex, Minimapsizey = _G["Minimap"]:GetSize()
			MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
			MinimapShadow:SetParent(_G["Minimap"])
			if not (self.minimapIsSkinned) then
				MinimapShadow.shadow = MinimapShadow:CreateShadow(nil, true)
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
							_G["MinimapPanel"]:CreateShadow()
						end
					end
				end
				MinimapShadow:Show()
				self.minimapIsSkinned = true
			end
		end

		--tooltip hp bar, one of the worst actually
		if _G.GameTooltipStatusBar and _G.GameTooltipStatusBar.backdrop and not _G.GameTooltipStatusBar.backdrop.shadow then
			local EltruismGameTooltipStatusBar = CreateFrame("Frame", "EltruismGameTooltipStatusBarShadowFrame")
			local GameTooltipStatusBarx, GameTooltipStatusBary = _G.GameTooltipStatusBar.backdrop:GetSize()
			EltruismGameTooltipStatusBar:SetSize(GameTooltipStatusBarx, GameTooltipStatusBary-3)
			EltruismGameTooltipStatusBar:SetParent(_G["GameTooltipStatusBar.backdrop"])
			if not (self.EltruismGameTooltipStatusBarIsSkinned) then
				EltruismGameTooltipStatusBar.shadow = EltruismGameTooltipStatusBar:CreateShadow()
				EltruismGameTooltipStatusBar:SetPoint("BOTTOMLEFT", _G.GameTooltipStatusBar.backdrop ,"BOTTOMLEFT", 0, 1)
				EltruismGameTooltipStatusBar:SetPoint("TOPRIGHT", _G.GameTooltipStatusBar.backdrop ,"TOPRIGHT", 0, 0)
				EltruismGameTooltipStatusBar:SetParent(_G.GameTooltipStatusBar.backdrop)
				EltruismGameTooltipStatusBar:Show()
				self.EltruismGameTooltipStatusBarIsSkinned = true
			end
		end

		--blizzard stuff that loads addon later
		local EltruismBlizzShadowsRetail = CreateFrame("Frame")
		EltruismBlizzShadowsRetail:RegisterEvent("ADDON_LOADED")
		EltruismBlizzShadowsRetail:SetScript("OnEvent", function(_, _, arg)
			if E.private.skins.blizzard.enable then
				if E.Retail then
					if (arg == "Blizzard_TalentUI") then
						_G.PlayerTalentFrame:HookScript("OnShow", function()
							if not _G.PlayerTalentFrame.shadow then
								_G.PlayerTalentFrame:CreateShadow()
							end
						end)
						_G.PlayerTalentFrameTab1:HookScript("OnShow", function()
							if _G.PlayerTalentFrameTab1 and _G.PlayerTalentFrameTab1.backdrop and not _G.PlayerTalentFrameTab1.backdrop.shadow then
								_G.PlayerTalentFrameTab1.backdrop:CreateShadow()
							end
						end)
						_G.PlayerTalentFrameTab2:HookScript("OnShow", function()
							if _G.PlayerTalentFrameTab2 and _G.PlayerTalentFrameTab2.backdrop and not _G.PlayerTalentFrameTab2.backdrop.shadow then
								_G.PlayerTalentFrameTab2.backdrop:CreateShadow()
							end
						end)
					end
				elseif not E.Retail then
					if (arg == "Blizzard_TalentUI") then
						_G.PlayerTalentFrame:HookScript("OnShow", function()
							if _G.PlayerTalentFrame and _G.PlayerTalentFrame.backdrop and not _G.PlayerTalentFrame.backdrop.shadow then
								_G.PlayerTalentFrame.backdrop:CreateShadow()
							end
							if _G.PlayerTalentFrameTab1 and _G.PlayerTalentFrameTab1.backdrop and not _G.PlayerTalentFrameTab1.backdrop.shadow then
								_G.PlayerTalentFrameTab1.backdrop:CreateShadow()
							end
							if _G.PlayerTalentFrameTab2 and _G.PlayerTalentFrameTab2.backdrop and not _G.PlayerTalentFrameTab2.backdrop.shadow then
								_G.PlayerTalentFrameTab2.backdrop:CreateShadow()
							end
							if _G.PlayerTalentFrameTab3 and _G.PlayerTalentFrameTab3.backdrop and not _G.PlayerTalentFrameTab3.backdrop.shadow then
								_G.PlayerTalentFrameTab3.backdrop:CreateShadow()
							end
							if _G.PlayerTalentFrameTab4 and _G.PlayerTalentFrameTab4.backdrop and not _G.PlayerTalentFrameTab4.backdrop.shadow then
								_G.PlayerTalentFrameTab4.backdrop:CreateShadow()
							end
							if _G.PlayerSpecTab1 and not _G.PlayerSpecTab1.shadow then
								_G.PlayerSpecTab1:CreateShadow()
							end
							if _G.PlayerSpecTab2 and not _G.PlayerSpecTab2.shadow then
								_G.PlayerSpecTab2:CreateShadow()
							end
						end)
					end
				end
				if (arg == "Blizzard_Calendar") then
					_G.CalendarFrame:HookScript("OnShow", function()
						if not _G.CalendarFrame.shadow then
							_G.CalendarFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_Communities") then
					_G.CommunitiesFrame:HookScript("OnShow", function()
						if not _G.CommunitiesFrame.shadow then
							_G.CommunitiesFrame:CreateShadow()
						end
						if _G.CommunitiesFrameTab1 and _G.CommunitiesFrameTab1.backdrop and not _G.CommunitiesFrameTab1.backdrop.shadow then
							_G.CommunitiesFrameTab1.backdrop:CreateShadow()
						end
						if _G.CommunitiesFrameTab2 and _G.CommunitiesFrameTab2.backdrop and not _G.CommunitiesFrameTab2.backdrop.shadow then
							_G.CommunitiesFrameTab2.backdrop:CreateShadow()
						end
						if _G.CommunitiesFrameTab3 and _G.CommunitiesFrameTab3.backdrop and not _G.CommunitiesFrameTab3.backdrop.shadow then
							_G.CommunitiesFrameTab3.backdrop:CreateShadow()
						end
						if _G.CommunitiesFrameTab4 and _G.CommunitiesFrameTab4.backdrop and not _G.CommunitiesFrameTab4.backdrop.shadow then
							_G.CommunitiesFrameTab4.backdrop:CreateShadow()
						end
						if _G.CommunitiesFrameTab5 and _G.CommunitiesFrameTab5.backdrop and not _G.CommunitiesFrameTab5.backdrop.shadow then
							_G.CommunitiesFrameTab5.backdrop:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_AchievementUI") then
					_G.AchievementFrame:HookScript("OnShow", function()
						if _G.AchievementFrame and _G.AchievementFrame.backdrop and not _G.AchievementFrame.backdrop.shadow then
							_G.AchievementFrame.backdrop:CreateShadow()
						end
					end)
					_G.AchievementFrameTab1:HookScript("OnShow", function()
						if _G.AchievementFrameTab1 and _G.AchievementFrameTab1.backdrop and not _G.AchievementFrameTab1.backdrop.shadow then
							_G.AchievementFrameTab1.backdrop:CreateShadow()
						end
					end)
					_G.AchievementFrameTab2:HookScript("OnShow", function()
						if _G.AchievementFrameTab2 and _G.AchievementFrameTab2.backdrop and not _G.AchievementFrameTab2.backdrop.shadow then
							_G.AchievementFrameTab2.backdrop:CreateShadow()
						end
					end)
					if E.Retail then
						_G.AchievementFrameTab3:HookScript("OnShow", function()
							if _G.AchievementFrameTab3 and _G.AchievementFrameTab3.backdrop and not _G.AchievementFrameTab3.backdrop.shadow then
								_G.AchievementFrameTab3.backdrop:CreateShadow()
							end
						end)
					end
				end
				if (arg == "Blizzard_GarrisonUI") then
					_G.GarrisonLandingPage:HookScript("OnShow", function()
						if not _G.GarrisonLandingPage.shadow then
							_G.GarrisonLandingPage:CreateShadow()
						end
					end)
					_G.CovenantMissionFrame:HookScript("OnShow", function()
						if not _G.CovenantMissionFrame.shadow then
							_G.CovenantMissionFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_CovenantSanctum") then
					_G.CovenantSanctumFrame:HookScript("OnShow", function()
						if not _G.CovenantSanctumFrame.shadow then
							_G.CovenantSanctumFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_Soulbinds") then
					_G.SoulbindViewer:HookScript("OnShow", function()
						if not _G.SoulbindViewer.shadow then
							_G.SoulbindViewer:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_Collections") then
					_G.CollectionsJournal:HookScript("OnShow", function()
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
					_G.CollectionsJournalTab1:HookScript("OnShow", function()
						if _G.CollectionsJournalTab1 and _G.CollectionsJournalTab1.backdrop and not _G.CollectionsJournalTab1.backdrop.shadow then
							_G.CollectionsJournalTab1.backdrop:CreateShadow()
						end
					end)
					_G.CollectionsJournalTab2:HookScript("OnShow", function()
						if _G.CollectionsJournalTab2 and _G.CollectionsJournalTab2.backdrop and not _G.CollectionsJournalTab2.backdrop.shadow then
							_G.CollectionsJournalTab2.backdrop:CreateShadow()
						end
					end)
					_G.CollectionsJournalTab3:HookScript("OnShow", function()
						if _G.CollectionsJournalTab3 and _G.CollectionsJournalTab3.backdrop and not _G.CollectionsJournalTab3.backdrop.shadow then
							_G.CollectionsJournalTab3.backdrop:CreateShadow()
						end
					end)
					_G.CollectionsJournalTab4:HookScript("OnShow", function()
						if _G.CollectionsJournalTab4 and _G.CollectionsJournalTab4.backdrop and not _G.CollectionsJournalTab4.backdrop.shadow then
							_G.CollectionsJournalTab4.backdrop:CreateShadow()
						end
					end)
					_G.CollectionsJournalTab5:HookScript("OnShow", function()
						if _G.CollectionsJournalTab5 and _G.CollectionsJournalTab5.backdrop and not _G.CollectionsJournalTab5.backdrop.shadow then
							_G.CollectionsJournalTab5.backdrop:CreateShadow()
						end
					end)
					_G.ToyBox:HookScript("OnShow", function()
						if not _G.ToyBox.shadow then
							_G.ToyBox:CreateShadow()
						end
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
					_G.HeirloomsJournal:HookScript("OnShow", function()
						if not _G.HeirloomsJournal.shadow then
							_G.HeirloomsJournal:CreateShadow()
						end
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
					_G.PetJournal:HookScript("OnShow", function()
						if not _G.PetJournal.shadow then
							_G.PetJournal:CreateShadow()
						end
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
					--[[_G.WardrobeCollectionFrame:HookScript("OnShow", function()
						if not _G.WardrobeCollectionFrame.shadow then
							_G.WardrobeCollectionFrame:CreateShadow()
						end
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)]]
					_G.WardrobeFrame:HookScript("OnShow", function()
						if not _G.WardrobeFrame.shadow then
							_G.WardrobeFrame:CreateShadow()
						end
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
					_G.MountJournal:HookScript("OnShow", function()
						if not _G.CollectionsJournal.shadow then
							_G.CollectionsJournal:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_PVPUI") then
					_G.PVPUIFrame:HookScript("OnShow", function()
						if not _G.PVPUIFrame.shadow then
							_G.PVPUIFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_VoidStorageUI") then
					_G.VoidStorageFrame:HookScript("OnShow", function()
						if not _G.VoidStorageFrame.shadow then
							_G.VoidStorageFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_ChallengesUI") then
					_G.PVEFrame:HookScript("OnShow", function()
						if not _G.PVEFrame.shadow then
							_G.PVEFrame:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_EncounterJournal") then
					_G.EncounterJournal:HookScript("OnShow", function()
						if not _G.EncounterJournal.shadow then
							_G.EncounterJournal:CreateShadow()
						end
					end)
				end
				if (arg == "Blizzard_WeeklyRewards") then
					_G.WeeklyRewardsFrame:HookScript("OnShow", function()
						if not _G.WeeklyRewardsFrame.shadow then
							_G.WeeklyRewardsFrame:CreateShadow()
						end
					end)
				end
			end
		end)

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
						frame:CreateShadow()
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
				_G.MailFrame,
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
			}
			for _, frame in pairs(retailframes) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end

			if E.private.actionbar.enable and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
				if not _G.BossButton.shadow then
					_G.BossButton:CreateShadow()
				end
			end
		elseif E.Wrath or E.TBC or E.Classic then

			--classic only elvui
			local ClassicElvUIFrames = {
			_G["ElvUF_PlayerTotem1"],
			_G["ElvUF_PlayerTotem2"],
			_G["ElvUF_PlayerTotem3"],
			_G["ElvUF_PlayerTotem4"],
			_G["ElvUF_PartyGroup1UnitButton1Pet"],
			_G["ElvUF_PartyGroup1UnitButton2Pet"],
			_G["ElvUF_PartyGroup1UnitButton3Pet"],
			_G["ElvUF_PartyGroup1UnitButton4Pet"],
			_G["ElvUF_PartyGroup1UnitButton5Pet"],
			}
			for _, frame in pairs(ClassicElvUIFrames) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end

			--raid pet
			for k = 1, 42 do
				local petunits = {_G["ElvUF_RaidpetGroup1UnitButton"..k]}
				for _, button in pairs(petunits) do
					if not button.shadow then
						button:CreateShadow()
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
				_G.MerchantFrame.backdrop,
				_G.WorldMapFrame,
				_G.CharacterFrameTab4.backdrop, --only in classic though
				_G.CharacterFrameTab5.backdrop, --only in classic though
				_G.FriendsFrameTab5.backdrop, --only in classic though
			}
			for _, frame in pairs(classicframes) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end
			--wrath/tbc only frames
			if E.Wrath or E.TBC then
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

			--wrath only frames
			if E.Wrath and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
				if _G.LFGListingFrame.backdrop and not _G.LFGListingFrame.backdrop.shadow then
					_G.LFGListingFrame.backdrop:CreateShadow()
				end
				if _G.LFGBrowseFrame.backdrop and not _G.LFGBrowseFrame.backdrop.shadow then
					_G.LFGBrowseFrame.backdrop:CreateShadow()
				end

				--Shaman Totem things
				if E.myclass == "SHAMAN" and (not E.db.ElvUI_EltreumUI.borders.borders) and E.private.general.totemBar then
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
							frame:CreateShadow()
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
								frame:CreateShadow()
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
		if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") and E.db.ElvUI_EltreumUI.skins.shadow.actionbars then
			--elvui action bars
			for i = 1, 10 do
				for k = 1, 12 do
					local slots = {_G["ElvUI_Bar"..i..'Button'..k]}
					for _, button in pairs(slots) do
						if not button.shadow and (not E.db.ElvUI_EltreumUI.borders.borders) then
							button:CreateShadow()
						end
						if button.shadow then
							if E.db.ElvUI_EltreumUI.borders.borders then
								button.shadow:Hide()
							else
								button.shadow:Show()
							end
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
					if not button.shadow and (not E.db.ElvUI_EltreumUI.borders.borders) then
						button:CreateShadow()
						--[[
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2]]
					end
					if button.shadow then
						if E.db.ElvUI_EltreumUI.borders.borders then
							button.shadow:Hide()
						else
							button.shadow:Show()
						end
					end
				end
			end
			if _G["ElvUI_BarPet"].backdrop then
				if not _G["ElvUI_BarPet"].backdrop.shadow then
					_G["ElvUI_BarPet"].backdrop:CreateShadow()
				end
			end

			--stances
			if not _G["EltruismStanceBorder1"] then
				for i = 1, 12 do
					local button = _G["ElvUI_StanceBarButton"..i]
					if not button then
						break
					else
						if not button.shadow then
							button:CreateShadow()
						end
					end
				end
			end

		end

		--microbar shadow
		if E.db.actionbar.microbar.enabled == true then
			if E.db.actionbar.microbar.backdrop == true then
				if _G.ElvUI_MicroBar and _G.ElvUI_MicroBar.backdrop and not _G.ElvUI_MicroBar.backdrop.shadow then
					_G.ElvUI_MicroBar.backdrop:CreateShadow()
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
						frame:CreateShadow()
					end
				end
			end
		end

		--unitframes
		if E.private.unitframe.enable then
			if E.Retail or E.Wrath or E.TBC then
				if not _G["ElvUF_Focus_HealthBar"].shadow then
					_G["ElvUF_Focus_HealthBar"]:CreateShadow()
				end
				if not _G["ElvUF_Focus_HealthBar"].shadow then
					_G["ElvUF_Focus_PowerBar"]:CreateShadow()
				end
			end

			local elvuiframes = {
				_G["ElvUF_TargetTarget_HealthBar"],
				_G["ElvUF_TargetTarget_PowerBar"],
				_G["ElvUF_Target_HealthBar"],
				_G["ElvUF_Target_PowerBar"],
				_G["ElvUF_Pet_HealthBar"],
				_G["ElvUF_Player_HealthBar"],
				_G["ElvUF_Player_PowerBar"],
				_G["ElvUF_Player_Stagger"],
				_G["ElvUF_Arena1"],
				_G["ElvUF_Arena2"],
				_G["ElvUF_Arena3"],
				_G["ElvUF_Arena4"],
				_G["ElvUF_Arena5"],
				--_G["ElvUF_Player_CastBar"],
				--_G["ElvUF_Target_CastBar"],
			}
			for _, frame in pairs(elvuiframes) do
				if frame then
					if not frame.shadow then
						if not E.db.ElvUI_EltreumUI.borders.borders then
							frame:CreateShadow()
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

			if E.db["unitframe"]["units"]["player"]["portrait"]["enable"] == true and E.db["unitframe"]["units"]["player"]["portrait"]["overlay"] == false then
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					if not E.db.ElvUI_EltreumUI.borders.borders then
						_G["ElvUF_Player"]:CreateShadow()
						_G["ElvUF_Player"].shadow:ClearAllPoints()
						_G["ElvUF_Player"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Player"] ,"TOPRIGHT", 3, 3)
						_G["ElvUF_Player"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player"] ,"BOTTOMLEFT", -3, -2)
						if _G["ElvUF_Player_HealthBar"].shadow then
							_G["ElvUF_Player_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Player_PowerBar"].shadow then
							_G["ElvUF_Player_PowerBar"].shadow:Hide()
						end
						if E.Retail then
							if _G["ElvUF_Player_Stagger"].shadow then
								_G["ElvUF_Player_Stagger"].shadow:Hide()
							end
						end
					end
				end
				--[[if _G["ElvUF_Player"].Portrait.backdrop and not _G["ElvUF_Player"].Portrait.backdrop.shadow then
					if (not E.db.ElvUI_EltreumUI.borders.playerborder) then
						_G["ElvUF_Player"].Portrait.backdrop:CreateShadow()
					end
				end]]
			end

			if E.db["unitframe"]["units"]["target"]["portrait"]["enable"] == true and E.db["unitframe"]["units"]["target"]["portrait"]["overlay"] == false then
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					if not E.db.ElvUI_EltreumUI.borders.borders then
						_G["ElvUF_Target"]:CreateShadow()
						_G["ElvUF_Target"].shadow:ClearAllPoints()
						_G["ElvUF_Target"].shadow:SetPoint("TOPRIGHT", _G["ElvUF_Target"] ,"TOPRIGHT", 3, 3)
						_G["ElvUF_Target"].shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target"] ,"BOTTOMLEFT", -3, -2)
						if _G["ElvUF_Target_HealthBar"].shadow then
							_G["ElvUF_Target_HealthBar"].shadow:Hide()
						end
						if _G["ElvUF_Target_PowerBar"].shadow then
							_G["ElvUF_Target_PowerBar"].shadow:Hide()
						end
					end
				end
				--[[if _G["ElvUF_Target"].Portrait.backdrop and not _G["ElvUF_Target"].Portrait.backdrop.shadow then
					if (not E.db.ElvUI_EltreumUI.borders.targetborder) then
						_G["ElvUF_Target"].Portrait.backdrop:CreateShadow()
					end
				end]]
			end

			--player castbar
			if E.db.unitframe.units.player.castbar.overlayOnFrame == "None" and (not E.db.ElvUI_EltreumUI.borders.borders) then
				if E.db.unitframe.units.player.castbar.iconAttached == false then
					PlayerCastbar:SetSize(E.db.unitframe.units.player.castbar.width + E.db.unitframe.units.player.castbar.iconSize -4, E.db.unitframe.units.player.castbar.height - 3)
				elseif E.db.unitframe.units.player.castbar.iconAttached == true then
					PlayerCastbar:SetSize(E.db.unitframe.units.player.castbar.width - 4, E.db.unitframe.units.player.castbar.height - 3)
				end
				PlayerCastbar:SetParent(_G["ElvUF_Player_CastBar"])
				if not (self.PlayerCastBarIsSkinned) then
					PlayerCastbar.shadow = PlayerCastbar:CreateShadow()
					self.PlayerCastBarIsSkinned = true
				end
				PlayerCastbar:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -((E.db.unitframe.units.player.castbar.height - 3)/2), 0)
				PlayerCastbar:Show()
				if _G["ElvUF_Player_CastBar"].shadow then
					_G["ElvUF_Player_CastBar"].shadow:Hide()
				end
			else
				if _G["EltruismPlayerCastBarShadowFrame"] then
					_G["EltruismPlayerCastBarShadowFrame"]:Hide()
				end
				if not _G["ElvUF_Player_CastBar"].shadow and (not E.db.ElvUI_EltreumUI.borders.borders) then
					_G["ElvUF_Player_CastBar"]:CreateShadow()
				end
				if _G["ElvUF_Player_CastBar"].shadow then
					_G["ElvUF_Player_CastBar"].shadow:Show()
				end
			end

			--target castbar
			if E.db.unitframe.units.target.castbar.overlayOnFrame == "None" and (not E.db.ElvUI_EltreumUI.borders.borders) then
				if E.db.unitframe.units.target.castbar.iconAttached == false then
					TargetCastbar:SetSize(E.db.unitframe.units.target.castbar.width + E.db.unitframe.units.target.castbar.iconSize - 4, E.db.unitframe.units.target.castbar.height - 3)
					if E.db["unitframe"]["units"]["target"]["castbar"]["iconPosition"] == "LEFT" then
						TargetCastbar:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -((E.db.unitframe.units.target.castbar.height - 3)/2), 0)
					elseif E.db["unitframe"]["units"]["target"]["castbar"]["iconPosition"] == "RIGHT" then
						TargetCastbar:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", ((E.db.unitframe.units.target.castbar.height - 3)/2), 0)
					end
				elseif E.db.unitframe.units.target.castbar.iconAttached == true then
					TargetCastbar:SetSize(E.db.unitframe.units.target.castbar.width - 4, E.db.unitframe.units.target.castbar.height - 3)
					TargetCastbar:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", ((E.db.unitframe.units.target.castbar.height - 3)/2), 0)
				end
				TargetCastbar:SetParent(_G["ElvUF_Target_CastBar"])
				if not (self.TargetCastBarIsSkinned) then
					TargetCastbar.shadow = TargetCastbar:CreateShadow()
					self.TargetCastBarIsSkinned = true
				end
				TargetCastbar:Show()
				if _G["ElvUF_Target_CastBar"].shadow then
					_G["ElvUF_Target_CastBar"].shadow:Hide()
				end
			else
				if _G["EltruismTargetCastBarShadowFrame"] then
					_G["EltruismTargetCastBarShadowFrame"]:Hide()
				end
				if not _G["ElvUF_Target_CastBar"].shadow and (not E.db.ElvUI_EltreumUI.borders.borders) then
					_G["ElvUF_Target_CastBar"]:CreateShadow()
				end
				if _G["ElvUF_Player_CastBar"].shadow then
					_G["ElvUF_Player_CastBar"].shadow:Show()
				end
			end

			--party
			for i = 1, 5 do
				local partymembers = {_G["ElvUF_PartyGroup1UnitButton"..i]}
				for _, frame in pairs(partymembers) do
					if not frame.shadow then
						if not E.db.ElvUI_EltreumUI.borders.borders then
							frame:CreateShadow()
						end
					end
					--[[for _, button in pairs(partymembers) do
						if not button.shadow then
							button:CreateShadow()
						end
					end]]
				end
			end

			--boss
			for i = 1, 8 do
				local bossmembers = {_G["ElvUF_Boss"..i]}
				for _, frame in pairs(bossmembers) do
					if not frame.shadow then
						if not E.db.ElvUI_EltreumUI.borders.borders then
							frame:CreateShadow()
						end
					end
					--[[for _, button in pairs(bossmembers) do
						if not button.shadow then
							button:CreateShadow()
						end
					end]]
				end
			end

			--tanks
			for i = 1, 8 do
				local tankmembers = {_G["ElvUF_TankUnitButton"..i]}
				for _, frame in pairs(tankmembers) do
					if not frame.shadow then
						frame:CreateShadow()
					end
					--[[for _, button in pairs(tankmembers) do
						if not button.shadow then
							button:CreateShadow()
						end
					end]]
				end
			end

			--assists
			for i = 1, 8 do
				local assistmembers = {_G["ElvUF_AssistUnitButton"..i]}
				for _, frame in pairs(assistmembers) do
					if not frame.shadow then
						frame:CreateShadow()
					end
					--[[for _, button in pairs(assistmembers) do
						if not button.shadow then
							button:CreateShadow()
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
							button:CreateShadow()
						end
					end
				end
			end

			--AdditionalPowerBar
			if E.myclass == 'DRUID' or E.myclass == 'SHAMAN' or E.myclass == 'PRIEST' then
				local additionalpowerbar = _G["ElvUF_Player_AdditionalPowerBar"]
				if additionalpowerbar ~= nil then
					if not _G["ElvUF_Player_AdditionalPowerBar"].shadow then
						_G["ElvUF_Player_AdditionalPowerBar"]:CreateShadow()
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
							button:CreateShadow()
						end
					end
				end
			end
		end

		--handle non spaced power and classpower
		if E.db["unitframe"]["units"]["target"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] == false then
			if _G["ElvUF_Target_PowerBar"] and _G["ElvUF_Target_PowerBar"].shadow then
				_G["ElvUF_Target_PowerBar"].shadow:Hide()
			end
			if _G["ElvUF_Target_HealthBar"] and _G["ElvUF_Target_HealthBar"].shadow then
				_G["ElvUF_Target_HealthBar"].shadow:Hide()
			end
			if E.db["unitframe"]["units"]["target"]["power"]["width"] == "inset" then
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"]:CreateShadow()
					_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_HealthBar"], "BOTTOMRIGHT",3,-3)
				end
			else
				if _G["ElvUF_Target"] and not _G["ElvUF_Target"].shadow then
					_G["ElvUF_Target"]:CreateShadow()
					_G["ElvUF_Target"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Target_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_Target"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"], "BOTTOMRIGHT",3,-3)
				end
			end
		end
		if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["targettarget"]["power"]["detachFromFrame"] == false then
			if _G["ElvUF_TargetTarget_PowerBar"] and _G["ElvUF_TargetTarget_PowerBar"].shadow then
				_G["ElvUF_TargetTarget_PowerBar"].shadow:Hide()
			end
			if _G["ElvUF_TargetTarget_HealthBar"] and _G["ElvUF_TargetTarget_HealthBar"].shadow then
				_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
			end
			if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "inset" then
				if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
					_G["ElvUF_TargetTarget"]:CreateShadow()
					_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_HealthBar"], "BOTTOMRIGHT",3,-3)
				end
			else
				if _G["ElvUF_TargetTarget"] and not _G["ElvUF_TargetTarget"].shadow then
					_G["ElvUF_TargetTarget"]:CreateShadow()
					_G["ElvUF_TargetTarget"].shadow:SetPoint("TOPLEFT", _G["ElvUF_TargetTarget_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_TargetTarget"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_TargetTarget_PowerBar"], "BOTTOMRIGHT",3,-3)
				end
			end
		end
		if E.db["unitframe"]["units"]["player"]["power"]["width"] ~= "spaced" and E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] == false then
			if _G["ElvUF_Player_PowerBar"] and _G["ElvUF_Player_PowerBar"].shadow then
				_G["ElvUF_Player_PowerBar"].shadow:Hide()
			end
			if _G["ElvUF_Player_HealthBar"] and _G["ElvUF_Player_HealthBar"].shadow then
				_G["ElvUF_Player_HealthBar"].shadow:Hide()
			end
			if E.db["unitframe"]["units"]["player"]["power"]["width"] == "inset" then
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"]:CreateShadow()
					_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_HealthBar"], "BOTTOMRIGHT",3,-3)
				end
			else
				if _G["ElvUF_Player"] and not _G["ElvUF_Player"].shadow then
					_G["ElvUF_Player"]:CreateShadow()
					_G["ElvUF_Player"].shadow:SetPoint("TOPLEFT", _G["ElvUF_Player_HealthBar"], "TOPLEFT",-3,3)
					_G["ElvUF_Player"].shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT",3,-3)
				end
			end
		end
		if E.db["unitframe"]["units"]["player"]["classbar"]["fill"] ~= "spaced" and not E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] == true then
			if _G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"].shadow then
				_G["ElvUF_Player_Stagger"].shadow:Hide()
			end
			if _G["ElvUF_Player_AdditionalPowerBar"] and _G["ElvUF_Player_AdditionalPowerBar"].shadow then
				_G["ElvUF_Player_AdditionalPowerBar"].shadow:Hide()
			end
		end


		--bags
		if E.private.bags.enable then
			if not _G.ElvUI_ContainerFrame.shadow then
				_G["ElvUI_ContainerFrame"]:CreateShadow()
			end
			if not _G.ElvUI_BankContainerFrame.shadow then
				_G["ElvUI_BankContainerFrame"]:CreateShadow()
			end
		end

		--elvui popup
		for i = 1, 5 do
			local ElvUI_StaticPopups = {_G["ElvUI_StaticPopup"..i]}
			for _, button in pairs(ElvUI_StaticPopups) do
				if not button.shadow then
					button:CreateShadow()
				end
			end
		end

		--chat
		local RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
		local rightsizex, rightsizey = _G["RightChatMover"]:GetSize()
		RightChatShadow:SetSize(rightsizex, rightsizey)
		RightChatShadow:SetParent(_G["RightChatPanel"].backdrop)
		local LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
		local leftsizex, leftsizey = _G["LeftChatMover"]:GetSize()
		LeftChatShadow:SetSize(leftsizex, leftsizey)
		LeftChatShadow:SetParent(_G["LeftChatPanel"].backdrop)

		if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
			if _G["RightChatPanel"] and _G["RightChatPanel"].backdrop and not _G["RightChatPanel"].backdrop.shadow and not E.db.ElvUI_EltreumUI.borders.borders then
				_G["RightChatPanel"].backdrop:CreateShadow()
			end
			if _G["LeftChatPanel"] and _G["LeftChatPanel"].backdrop and not _G["LeftChatPanel"].backdrop.shadow and not E.db.ElvUI_EltreumUI.borders.borders then
				_G["LeftChatPanel"].backdrop:CreateShadow()
			end
		else
			if not (self.RightChatIsSkinned) and not E.db.ElvUI_EltreumUI.borders.borders then
				RightChatShadow.shadow = RightChatShadow:CreateShadow(nil, true)
				RightChatShadow:SetPoint("TOPRIGHT", _G["RightChatPanel"] ,"TOPRIGHT", 0, 0)
				RightChatShadow:SetPoint("BOTTOMLEFT", _G["RightChatDataPanel"] ,"BOTTOMLEFT", 0, 0)
				RightChatShadow:Show()
				self.RightChatIsSkinned = true
			end
			if not (self.LeftChatIsSkinned) and not E.db.ElvUI_EltreumUI.borders.borders then
				LeftChatShadow.shadow = LeftChatShadow:CreateShadow(nil, true)
				LeftChatShadow:SetPoint("TOPLEFT", _G["LeftChatPanel"] ,"TOPLEFT", 0, 0)
				LeftChatShadow:SetPoint("BOTTOMRIGHT", _G["LeftChatDataPanel"] ,"BOTTOMRIGHT", 0, 0)
				LeftChatShadow:Show()
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
		------------------------------------------------------------------------------------------------------end of elvui frames
		if IsAddOnLoaded('ProjectAzilroka') then
			if not _G.stAMFrame.shadow then
				_G.stAMFrame:CreateShadow()
			end

			if not _G.stAMProfileMenu.shadow then
				_G.stAMProfileMenu:CreateShadow()
			end

			if not _G.SquareMinimapButtonBar.shadow then
				_G.SquareMinimapButtonBar:CreateShadow()
			end
		end
	end
end

function ElvUI_EltreumUI:RaidShadows()
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.raid then
		--raid
		for i = 1, 3 do
			for k = 1, 8 do
				for l = 1, 5 do
					local slots = {_G["ElvUF_Raid"..i..'Group'..k..'UnitButton'..l]}
					for _, button in pairs(slots) do
						if not button.shadow then
							if not E.db.ElvUI_EltreumUI.borders.borders then
								button:CreateShadow()
								button.shadow:SetParent(button)
							end
						end
					end
				end
			end
		end
	end
end

--benik's version
function ElvUI_EltreumUI:NameplateShadows(nameplate)
	if E.private.nameplates.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable then
		if E.db.ElvUI_EltreumUI.skins.shadow.nameplates then
			if nameplate.Health.backdrop then
				if not nameplate.Health.backdrop.shadow then
					nameplate.Health.backdrop:CreateShadow()
				end
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
			if nameplate.Power.backdrop then
				if not nameplate.Power.backdrop.shadow then
					nameplate.Power.backdrop:CreateShadow()
				end
			end
			if _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"].shadow then
				_G["ElvNP_TargetClassPowerClassPower"]:CreateShadow()
			end
			if _G["EltruismPowerBar"] and not _G["EltruismPowerBar"].shadow then
				_G["EltruismPowerBar"]:CreateShadow()
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.npcastbar then
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

		if E.db.ElvUI_EltreumUI.skins.shadow.npportraits then
			if nameplate.Portrait.backdrop then
				if not nameplate.Portrait.backdrop.shadow then
					nameplate.Portrait.backdrop:CreateShadow()
				end
			end
		end
	end
end
hooksecurefunc(NP, 'StylePlate', ElvUI_EltreumUI.NameplateShadows) --nameplate shadows

function ElvUI_EltreumUI:Construct_AuraIcon(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.npauras and E.private.nameplates.enable then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(NP, 'Construct_AuraIcon', ElvUI_EltreumUI.Construct_AuraIcon) --nameplate buffs/debuffs shadows

function ElvUI_EltreumUI:AuraShadows(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.aura and E.private.auras.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable then
		if not button then return end
		if not button.shadow then
			if not E.db.ElvUI_EltreumUI.borders.borders then
				button:CreateShadow()
			end
		end
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraShadows) --aura (minimap) shadows

function ElvUI_EltreumUI:UFAuraShadows(button)
	if E.db.ElvUI_EltreumUI.skins.shadow.ufaura and E.private.auras.enable and E.db.ElvUI_EltreumUI.skins.shadow.enable then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(UF, 'Construct_AuraIcon', ElvUI_EltreumUI.UFAuraShadows) --uf aura shadows

