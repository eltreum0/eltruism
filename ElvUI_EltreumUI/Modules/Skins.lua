local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParentOVERLAY
local IsAddOnLoaded = _G.IsAddOnLoaded
local LoadAddOn = _G.LoadAddOn
local hooksecurefunc = _G.hooksecurefunc
local PetStableFrame = _G.PetStableFrame
local PetStableNextPageButton =  _G.PetStableNextPageButton
local PetStablePrevPageButton = _G.PetStablePrevPageButton
local PetStableFrameModelBg = _G.PetStableFrameModelBg
local PetStableModel = _G.PetStableModel
local PetStableStabledPet1 = _G.PetStableStabledPet1
local SEARCH = _G.SEARCH
local NAME = _G.NAME
local PET_FAMILIES = _G.PET_FAMILIES
local PET_TALENTS = _G.PET_TALENTS
local GetStablePetInfo = _G.GetStablePetInfo

function ElvUI_EltreumUI:SkinsInit()
	ElvUI_EltreumUI:Skins()
	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel then
		ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	end
end

local classIcons = {
	['WARRIOR'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warrior",
	['PALADIN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Paladin",
	['HUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Hunter",
	['ROGUE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Rogue",
	['PRIEST'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Priest",
	['DEATHKNIGHT'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnight",
	['SHAMAN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Shaman",
	['MAGE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Mage",
	['WARLOCK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warlock",
	['MONK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Monk",
	['DRUID'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Druid",
	['DEMONHUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunter",
}

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	['WARRIOR'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarriorIconReleaf",
	['PALADIN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PaladinIconReleaf",
	['HUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/HunterIconReleaf",
	['ROGUE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/RogueIconReleaf",
	['PRIEST'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/PriestIconReleaf",
	['DEATHKNIGHT'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnightIconReleaf",
	['SHAMAN'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/ShamanIconReleaf",
	['MAGE'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MageIconReleaf",
	['WARLOCK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/WarlockIconReleaf",
	['MONK'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/MonkIconReleaf",
	['DRUID'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DruidIconReleaf",
	['DEMONHUNTER'] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunterIconReleaf",
}



--add class icon to class in character panel
local classFrame = CreateFrame("Frame", "EltruismClassIcon", UIParent)
classFrame:SetSize(20, 20)
classFrame:SetParent("PaperDollFrame")
local classTexture = classFrame:CreateTexture()
classTexture:SetAllPoints(classFrame)
local CharacterLevelText = _G.CharacterLevelText
if ElvUI_EltreumUI.Retail then
	CharacterLevelText:SetWidth(300) --new
elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
	CharacterLevelText:SetWidth(280) --new
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	classFrame:ClearAllPoints()
	--type of icon
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
		classTexture:SetTexture(classIcons[E.myclass])
	elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
		classTexture:SetTexture(classIconsReleafborder[E.myclass])
	else
		classTexture:SetTexture(classIcons[E.myclass])
	end
	local textwidth = CharacterLevelText:GetUnboundedStringWidth()
	local levelwidth = CharacterLevelText:GetWidth()
	local totalgap = levelwidth - textwidth
	local gapclassic = totalgap/4
	local gapretail = totalgap/4
	if ElvUI_EltreumUI.Retail then
		--print(gapretail)
		if gapretail <= 20 then
			classFrame:SetPoint("RIGHT", "CharacterLevelText", -15, 0)
		elseif gapretail > 20 and gapretail <=30 then
			classFrame:SetPoint("RIGHT", "CharacterLevelText", -15, 0)
		elseif gapretail > 30 and gapretail < 40 then
			classFrame:SetPoint("RIGHT", "CharacterLevelText", (0-gapretail)/2, 0)
		elseif gapretail >= 40 then
			classFrame:SetPoint("RIGHT", "CharacterLevelText", (0-gapretail), 0)
		end
	end
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		classFrame:SetPoint("RIGHT", "CharacterLevelText", -gapclassic, 0)
	end
end

function ElvUI_EltreumUI:Skins()
	--Reskin Blizzard Talent frame for TBC
	if ElvUI_EltreumUI.TBC then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			if not IsAddOnLoaded("Blizzard_TalentUI") then
				LoadAddOn("Blizzard_TalentUI")
			end
			--assert(IsAddOnLoaded("Blizzard_TalentUI"), "Talent UI not loaded")

			--hide the scroll
			if _G.PlayerTalentFrameScrollFrameScrollBar then
				_G.PlayerTalentFrameScrollFrameScrollBar:Hide()
			end
			--increase the size of the whole frame
			if _G.PlayerTalentFrame then
				_G.PlayerTalentFrame:SetSize(376, 780)
			end
			if _G.PlayerTalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 580)
				--set the position
				_G.PlayerTalentFrameScrollFrame:ClearAllPoints()
				_G.PlayerTalentFrameScrollFrame:SetPoint("CENTER", _G.PlayerTalentFrame, 0, 20)
			end
			--kill stuff
			if _G.PlayerTalentFrameBackgroundTopRight then
				_G.PlayerTalentFrameBackgroundTopRight:Kill()
			end
			if _G.PlayerTalentFrameBackgroundBottomLeft then
				_G.PlayerTalentFrameBackgroundBottomLeft:Kill()
			end
			if _G.PlayerTalentFrameBackgroundBottomRight then
				_G.PlayerTalentFrameBackgroundBottomRight:Kill()
			end
			--increase the size of the background
			if _G.PlayerTalentFrameBackgroundTopLeft then
				_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 600)
			end
		end
	end

	--Reskin Blizzard Talent frame for Classic
	if ElvUI_EltreumUI.Classic then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			if not IsAddOnLoaded("Blizzard_TalentUI") then
				LoadAddOn("Blizzard_TalentUI")
			end
			--assert(IsAddOnLoaded("Blizzard_TalentUI"), "Talent UI not loaded")

			--hide the scroll
			if _G.TalentFrameScrollFrameScrollBar then
				_G.TalentFrameScrollFrameScrollBar:Hide()
			end
			--increase the size of the whole frame
			if _G.TalentFrame then
				_G.TalentFrame:SetSize(376, 670)
			end
			if _G.TalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				_G.TalentFrameScrollFrame:SetSize( 280 , 470)
				--set the position
				_G.TalentFrameScrollFrame:ClearAllPoints()
				_G.TalentFrameScrollFrame:SetPoint("CENTER", _G.TalentFrame, 0, 20)
			end
			--kill stuff
			if _G.TalentFrameBackgroundTopRight then
				_G.TalentFrameBackgroundTopRight:Kill()
			end
			if _G.TalentFrameBackgroundBottomLeft then
				_G.TalentFrameBackgroundBottomLeft:Kill()
			end
			if _G.TalentFrameBackgroundBottomRight then
				_G.TalentFrameBackgroundBottomRight:Kill()
			end
			--increase the size of the background
			if _G.TalentFrameBackgroundTopLeft then
				_G.TalentFrameBackgroundTopLeft:SetSize(310 , 490)
			end
		end
	end

	-- Color level up display and boss banner originally by Aftermathh, 9.1 partially by Eltreum
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.enable then
			local R, G, B = unpack(E.media.rgbvaluecolor)
			local BossBanner = _G.BossBanner
			local EventToastManagerFrame = _G.EventToastManagerFrame

			if EventToastManagerFrame then
				_G.EventToastManagerFrame.GLine:SetVertexColor(R, G, B)
				_G.EventToastManagerFrame.GLine2:SetVertexColor(R, G, B)
				EventToastManagerFrame.StatusLine = CreateFrame("StatusBar", "EltruismEventToastLine", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine:SetSize(418, 3)
				EventToastManagerFrame.StatusLine:SetPoint("TOP", EventToastManagerFrame, 0, -5)
				EventToastManagerFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine:SetStatusBarColor(R, G, B, 1)
				EventToastManagerFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismEventToastLine2", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine2:SetSize(418, 3)
				EventToastManagerFrame.StatusLine2:SetPoint("BOTTOM", EventToastManagerFrame, 0, 0)
				EventToastManagerFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine2:SetStatusBarColor(R, G, B, 1)
				--EventToastManagerFrame.currentDisplayingToast.BannerFrame:Kill()  --lets try
				--/script EventToastManagerFrame:Show()
			end

			--test
			if E.db.ElvUI_EltreumUI.skins.bossemote then
				local RaidBossEmoteFrame = _G.RaidBossEmoteFrame
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
				RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
			end

			if BossBanner then
				local StatusLineTop = CreateFrame("StatusBar", nil, _G.BossBanner)
				StatusLineTop:SetSize(418, 2)
				--(point, relativeTo, relativePoint, offset_x, offset_y)
				StatusLineTop:SetPoint("TOP", _G.BossBanner, 0, -80)
				StatusLineTop:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineTop:SetStatusBarColor(R, G, B, 0.7)
				local StatusLineBottom = CreateFrame("StatusBar", nil, _G.BossBanner)
				StatusLineBottom:SetSize(418, 2)
				StatusLineBottom:SetPoint("BOTTOM", _G.BossBanner, 0, -20)
				StatusLineBottom:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineBottom:SetStatusBarColor(R, G, B, 0.7)
				_G.BossBanner.BannerTop:Kill()
				_G.BossBanner.BannerTopGlow:Kill()
				_G.BossBanner.BannerBottom:Kill()
				_G.BossBanner.BannerBottomGlow:Kill()
				_G.BossBanner.BannerMiddle:Kill()
				--_G.BossBanner.BannerMiddle:SetTexture(E.Media.Textures.Highlight)
				--_G.BossBanner.BannerMiddle:SetColorTexture(0, 0, 0, 0.20)
				_G.BossBanner.BannerMiddleGlow:Kill()
				_G.BossBanner.LootCircle:Kill()
				_G.BossBanner.SkullCircle:Kill()
				_G.BossBanner.RightFillagree:Kill()
				_G.BossBanner.LeftFillagree:Kill()
				_G.BossBanner.BottomFillagree:Kill()
				_G.BossBanner.SkullSpikes:Kill()
				--/script BossBanner:Show()
			end
		end
	end
end

--Wider Transmog Window
local EltruismWiderTransmog = CreateFrame("Frame", "EltruismWiderTransmog")
EltruismWiderTransmog:RegisterEvent("ADDON_LOADED")
EltruismWiderTransmog:SetScript("OnEvent",
	function(_, _, arg)
		if (arg == "Blizzard_Collections") then
			WardrobeTransmogFrame:HookScript("OnShow",
				function()
					if E.db.ElvUI_EltreumUI.skins.widertransmog then
						--whole window
						_G.WardrobeFrame:SetWidth(1200)
						--player model frame
						_G.WardrobeTransmogFrame:SetWidth(530)
						_G.WardrobeTransmogFrame:SetHeight(_G.WardrobeFrame:GetHeight() -130)
						_G.WardrobeTransmogFrame:SetPoint("TOP", _G.WardrobeFrame, 0, 0)
						_G.WardrobeTransmogFrame.ModelScene:ClearAllPoints()
						_G.WardrobeTransmogFrame.ModelScene:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 20, 10)
						_G.WardrobeTransmogFrame.ModelScene:SetAllPoints(_G.WardrobeTransmogFrame)
						--_G.WardrobeTransmogFrame.ModelScene:SetWidth(500)
						--_G.WardrobeTransmogFrame.ModelScene:SetHeight(450)
						_G.WardrobeOutfitDropDown:ClearAllPoints()
						_G.WardrobeOutfitDropDown:SetPoint("TOPLEFT", _G.WardrobeTransmogFrame, "TOPLEFT", 0, 50)

						--head button (with the help of gregory)
						_G.WardrobeTransmogFrame.HeadButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.HeadButton:SetPoint("TOPLEFT", _G.WardrobeTransmogFrame, "TOPLEFT", 20, 0)

						---shoulder button
						_G.WardrobeTransmogFrame.ShoulderButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.ShoulderButton:SetPoint("TOP", _G.WardrobeTransmogFrame.HeadButton, "TOP", 0, -55)

						--shoulder toggle for offshoulder
						_G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:ClearAllPoints()
						_G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("BOTTOM", _G.WardrobeCollectionFrame, "BOTTOM", -240, 40)

						--background
						_G.WardrobeTransmogFrame.Inset.BG:SetAllPoints(_G.WardrobeTransmogFrame)

						--hands button
						_G.WardrobeTransmogFrame.HandsButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.HandsButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 240, -120)
						--main weapon
						_G.WardrobeTransmogFrame.MainHandButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "BOTTOM", -50, 50)
						--offhand
						_G.WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame, "BOTTOM", 50, 50)
						--and their enchants
						_G.WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -28)
						_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints()
						_G.WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -28)
						_G.UIPanelWindows["WardrobeFrame"].width = 1200
					end
				end
			)
		end
	end
)

--based on Improved Stable Frame by Cybeloras
function ElvUI_EltreumUI:ExpandedStable()
	if E.db.ElvUI_EltreumUI.skins.expandedstable then
		local maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS
		local NUM_PER_ROW = 10

		for i = NUM_PET_STABLE_SLOTS + 1, maxSlots do
			if not _G["PetStableStabledPet"..i] then
				CreateFrame("Button", "PetStableStabledPet"..i, PetStableFrame, "PetStableSlotTemplate", i)
			end
		end

		for i = 1, maxSlots do
			local frame = _G["PetStableStabledPet"..i]
			if i > 1 then
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", _G["PetStableStabledPet"..i-1], "RIGHT", 7.3, 0)
			end
			frame:SetFrameLevel(PetStableFrame:GetFrameLevel() + 1)
			frame:SetScale(7/NUM_PER_ROW)
			frame.dimOverlay = frame:CreateTexture(nil, "OVERLAY")
			frame.dimOverlay:SetColorTexture(0, 0, 0, 0.8)
			frame.dimOverlay:SetAllPoints()
			frame.dimOverlay:Hide()
		end

		for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do
			_G["PetStableStabledPet"..i]:ClearAllPoints()
			_G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -5)
		end

		PetStableNextPageButton:Hide()
		PetStablePrevPageButton:Hide()
		local widthDelta = 315
		local heightDelta = 204
		local f = CreateFrame("Frame", "ExpandedStable", PetStableFrame, "InsetFrameTemplate")
		f:ClearAllPoints()
		f:SetSize(widthDelta, PetStableFrame:GetHeight() + heightDelta - 28)
		f:SetPoint(PetStableFrame.Inset:GetPoint(1))
		PetStableFrame.Inset:SetPoint("TOPLEFT", f, "TOPRIGHT")
		PetStableFrame:SetWidth(PetStableFrame:GetWidth() + widthDelta)
		PetStableFrame:SetHeight(PetStableFrame:GetHeight() + heightDelta)
		PetStableFrameModelBg:SetHeight(281 + heightDelta)

		local p, r, rp, x, y = PetStableModel:GetPoint(1)
		PetStableModel:SetPoint(p, r, rp, x, y - 32)
		PetStableStabledPet1:ClearAllPoints()
		PetStableStabledPet1:SetPoint("TOPLEFT", f, 8, -36)

		local searchInput = CreateFrame("EditBox", "ES_SearchInput", f, "SearchBoxTemplate")
		searchInput:SetPoint("TOPLEFT", 9, 0)
		searchInput:SetPoint("RIGHT", -3, 0)
		searchInput:SetHeight(20)

		local function ExpandedStable_Update()
			--local input = ES_SearchInput:GetText()
			local input = searchInput:GetText()
			if not input or input:trim() == "" then
				for i = 1, maxSlots do
					local button = _G["PetStableStabledPet"..i]
					button.dimOverlay:Hide()
				end
				return
			end

			for i = 1, maxSlots do
				local icon, name, _, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i)
				--local icon, name, level, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i)
				local button = _G["PetStableStabledPet"..i]

				button.dimOverlay:Show()
				if icon then
					local matched, expected = 0, 0
					for str in input:gmatch("([^%s]+)") do
						expected = expected + 1
						str = str:trim():lower()

						if name:lower():find(str)
						or family:lower():find(str)
						or talent:lower():find(str)
						then
							matched = matched + 1
						end
					end
					if matched == expected then
						button.dimOverlay:Hide()
					end
				end
			end
		end
		searchInput:HookScript("OnTextChanged", ExpandedStable_Update)
		searchInput.Instructions:SetText(SEARCH .. " (" .. NAME .. ", " .. PET_FAMILIES .. ", " .. PET_TALENTS  .. ")")
		hooksecurefunc("PetStable_Update", ExpandedStable_Update)
		NUM_PET_STABLE_SLOTS = maxSlots
		NUM_PET_STABLE_PAGES = 1
		PetStableFrame.page = 1
		PetStableFrame:HookScript("OnShow", function()
			if not IsAddOnLoaded("ExpandedStable") then
				LoadAddOn("ExpandedStable")
			end
		end)
	end
end
