local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local EltruismExpandedTalents = CreateFrame("Frame")

--Reskin Blizzard Talent frame
function ElvUI_EltreumUI:ExpandedTalents()
	if E.Retail then
		EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
		EltruismExpandedTalents:RegisterEvent("PLAYER_ENTERING_WORLD")
		EltruismExpandedTalents:RegisterEvent("PLAYER_STARTED_MOVING")
		EltruismExpandedTalents:RegisterEvent("FIRST_FRAME_RENDERED")
		EltruismExpandedTalents:RegisterEvent("PLAYER_LOGIN")
		EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
			if (arg == "Blizzard_PlayerSpells") or IsAddOnLoaded("Blizzard_PlayerSpells") then
				EltruismExpandedTalents:UnregisterAllEvents()

				_G.PlayerSpellsFrame:SetMovable(true)
				_G.PlayerSpellsFrame:EnableMouse(true)
				_G.PlayerSpellsFrame:RegisterForDrag("LeftButton")
				_G.PlayerSpellsFrame:SetScript("OnDragStart", _G.PlayerSpellsFrame.StartMoving)
				_G.PlayerSpellsFrame:SetScript("OnDragStop", _G.PlayerSpellsFrame.StopMovingOrSizing)
				_G.PlayerSpellsFrame:SetClampedToScreen(true)

				local function adjustscale()
					if not InCombatLockdown() then
						_G.PlayerSpellsFrame:SetScale(E.db.ElvUI_EltreumUI.skins.expandedtalentscale)
					end
				end
				_G.PlayerSpellsFrame:HookScript("OnShow", function()
					adjustscale()
				end)
				_G.PlayerSpellsFrame:HookScript("OnEvent", function()
					adjustscale()
				end)
			end
		end)
	elseif E.Cata then
		EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
		EltruismExpandedTalents:RegisterEvent("PLAYER_ENTERING_WORLD")
		EltruismExpandedTalents:RegisterEvent("PLAYER_STARTED_MOVING")
		EltruismExpandedTalents:RegisterEvent("FIRST_FRAME_RENDERED")
		EltruismExpandedTalents:RegisterEvent("PLAYER_LOGIN")
		EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
			if (arg == "Blizzard_TalentUI") or IsAddOnLoaded("Blizzard_TalentUI") then
				EltruismExpandedTalents:UnregisterAllEvents()

				local function adjustscale()
					_G.PlayerTalentFrame:SetScale(E.db.ElvUI_EltreumUI.skins.expandedtalentscale)
				end
				_G.PlayerTalentFrame:HookScript("OnShow", function()
					adjustscale()
				end)
				_G.PlayerTalentFrame:HookScript("OnEvent", function()
					adjustscale()
				end)
			end
		end)
	else
		if E.db.ElvUI_EltreumUI.skins.tbctalents and E.private.skins.blizzard.enable and E.private.skins.blizzard.talent then
			EltruismExpandedTalents:RegisterEvent("ADDON_LOADED")
			EltruismExpandedTalents:RegisterEvent("PLAYER_ENTERING_WORLD")
			EltruismExpandedTalents:SetScript("OnEvent", function(_,_,arg)
				if arg == "Blizzard_TalentUI" or IsAddOnLoaded("Blizzard_TalentUI") then
					local PlayerTalentFrame = _G.PlayerTalentFrame
					local PlayerTalentFrameScrollFrameScrollBar = _G.PlayerTalentFrameScrollFrameScrollBar
					local PlayerTalentFrameScrollFrame = _G.PlayerTalentFrameScrollFrame
					local PlayerTalentFrameBackgroundTopRight = _G.PlayerTalentFrameBackgroundTopRight
					local PlayerTalentFrameBackgroundBottomLeft = _G.PlayerTalentFrameBackgroundBottomLeft
					local PlayerTalentFrameBackgroundBottomRight = _G.PlayerTalentFrameBackgroundBottomRight
					local PlayerTalentFrameBackgroundTopLeft = _G.PlayerTalentFrameBackgroundTopLeft
					local PlayerTalentFrameCancelButton = _G.PlayerTalentFrameCancelButton

					EltruismExpandedTalents:UnregisterAllEvents()
					--hide the scroll
					if PlayerTalentFrameScrollFrameScrollBar then
						PlayerTalentFrameScrollFrameScrollBar:ClearAllPoints()
						PlayerTalentFrameScrollFrameScrollBar:Hide()
					end

					--increase the size of the whole frame
					if PlayerTalentFrame then
						PlayerTalentFrame:SetSize(376, 670)
					end

					--fix rank size
					for i =1, MAX_NUM_TALENTS do
						if _G["PlayerTalentFrameTalent"..i.."Rank"] then
							_G["PlayerTalentFrameTalent"..i.."Rank"]:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize+4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						end
					end

					if PlayerTalentFrameScrollFrame then
						--increase the size of the actual frame that has the talent buttons
						if E.Classic then
							PlayerTalentFrameScrollFrame:SetSize( 280 , 470)
						end
						--set the position
						PlayerTalentFrameScrollFrame:ClearAllPoints()
						if E.Classic then
							PlayerTalentFrameScrollFrame:SetPoint("TOP", PlayerTalentFrame, "TOP", -22, -37)
						end
					end

					--increase the size of the background
					if PlayerTalentFrameBackgroundTopLeft then
						if E.Classic then
							--PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 490)
							if PlayerTalentFrameScrollFrame.backdrop then
								PlayerTalentFrameScrollFrame.backdrop:Kill()
							end
							PlayerTalentFrameBackgroundTopLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundTopLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopLeft:SetPoint("TOPLEFT", PlayerTalentFrameScrollFrame, "TOPLEFT", 0, 0)
							PlayerTalentFrameBackgroundTopLeft:SetSize(204, 374)

							PlayerTalentFrameBackgroundBottomLeft:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomLeft:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomLeft:SetPoint("BOTTOMLEFT", PlayerTalentFrameScrollFrame, "BOTTOMLEFT", 0, -54)
							PlayerTalentFrameBackgroundBottomLeft:SetSize(204, 150)

							PlayerTalentFrameBackgroundTopRight:ClearAllPoints()
							PlayerTalentFrameBackgroundTopRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundTopRight:SetPoint("TOPRIGHT", PlayerTalentFrameScrollFrame, "TOPRIGHT", 24, 0)
							PlayerTalentFrameBackgroundTopRight:SetSize(100, 374)

							PlayerTalentFrameBackgroundBottomRight:ClearAllPoints()
							PlayerTalentFrameBackgroundBottomRight:SetParent(PlayerTalentFrame)
							PlayerTalentFrameBackgroundBottomRight:SetPoint("BOTTOMRIGHT", PlayerTalentFrameScrollFrame, "BOTTOMRIGHT", 24, -54)
							PlayerTalentFrameBackgroundBottomRight:SetSize(100, 150)
						end
					end
					--hide the close button (only shows up for some people?)
					if PlayerTalentFrameCancelButton then
						PlayerTalentFrameCancelButton:Hide()
					end

					-- fix talent frame position due to expanded character bg
					_G.PlayerTalentFrame:HookScript("OnShow", function()
						if E.db.ElvUI_EltreumUI.skins.classicarmory then
							if _G.CharacterModelFrame:IsVisible() then
								_G.PlayerTalentFrame:ClearAllPoints()
								_G.PlayerTalentFrame:SetPoint("TOPLEFT", _G.CharacterFrame, "TOPRIGHT", -30, 0)
								_G.PlayerTalentFrame:SetScale(E.db.ElvUI_EltreumUI.skins.expandedtalentscale)
							end
						end
					end)
				end
			end)
		end
	end
end
