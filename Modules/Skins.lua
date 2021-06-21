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
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if ElvUI_EltreumUI.Retail then
		ElvUI_EltreumUI:WiderTransmog()
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

local classFrame = CreateFrame("Frame", nil, UIParent)
classFrame:ClearAllPoints()
classFrame:SetSize(20, 20)
classFrame:SetParent("PaperDollFrame")
local classTexture = classFrame:CreateTexture()
classTexture:SetAllPoints(classFrame)
classTexture:SetTexture(classIcons[E.myclass])

--add class icon to class in character panel
function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	local CharacterLevelText = _G.CharacterLevelText
	local textwidth = CharacterLevelText:GetUnboundedStringWidth()
	local levelwidth = CharacterLevelText:GetWidth()
	local totalgap = levelwidth - textwidth
	local gap = totalgap/8
	if ElvUI_EltreumUI.Retail then
		classFrame:SetPoint("LEFT", "CharacterLevelText", levelwidth-gap, 0)
	end
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		classFrame:SetPoint("CENTER", "CharacterLevelText", (levelwidth/2)+25, 0)
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

	-- Color level up display and boss banner by Aftermathh
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.enable then
			local R, G, B = unpack(E.media.rgbvaluecolor)
			local LevelUpDisplay = _G.LevelUpDisplay
			local BossBanner = _G.BossBanner
			if LevelUpDisplay then
				_G.LevelUpDisplayGLine:Kill()
				_G.LevelUpDisplayGLine2:Kill()
				LevelUpDisplay.StatusLine = CreateFrame("StatusBar", nil, LevelUpDisplay)
				LevelUpDisplay.StatusLine:SetSize(418, 2)
				LevelUpDisplay.StatusLine:SetPoint("TOP", LevelUpDisplay, 0, -5)
				LevelUpDisplay.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				LevelUpDisplay.StatusLine:SetStatusBarColor(R, G, B, 0.7)
				LevelUpDisplay.StatusLine2 = CreateFrame("StatusBar", nil, LevelUpDisplay)
				LevelUpDisplay.StatusLine2:SetSize(418, 2)
				LevelUpDisplay.StatusLine2:SetPoint("BOTTOM", LevelUpDisplay, 0, -3)
				LevelUpDisplay.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				LevelUpDisplay.StatusLine2:SetStatusBarColor(R, G, B, 0.7)
				_G.LevelUpDisplay.challengeModeBits:Kill()
	    		_G.LevelUpDisplay.scenarioBits:Kill()
	    		_G.LevelUpDisplay.scenarioFiligree:Kill()
	    		_G.LevelUpDisplay.SpellBucketFrame:Kill()
				--/script LevelUpDisplay:Show()
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

function ElvUI_EltreumUI:WiderTransmog()
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.widertransmog then
			if not IsAddOnLoaded("Blizzard_Collections") then
				LoadAddOn("Blizzard_Collections")
			end
			--whole window
			_G.WardrobeFrame:SetWidth(1200)
			--player model frame
			_G.WardrobeTransmogFrame:SetWidth(600)
			_G.WardrobeTransmogFrame:SetHeight(_G.WardrobeFrame:GetHeight() -100);
			_G.WardrobeTransmogFrame:SetPoint("TOPLEFT", _G.WardrobeFrame, -10, -60)
			_G.WardrobeTransmogFrame.ModelScene:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene:SetPoint("TOP", _G.WardrobeTransmogFrame, "TOP", 0, 0)
			_G.WardrobeTransmogFrame.ModelScene:SetWidth(450)
			_G.WardrobeTransmogFrame.ModelScene:SetHeight(450)
			--left side
			_G.WardrobeTransmogFrame.ModelScene.HeadButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.HeadButton:SetPoint("TOP", _G.WardrobeTransmogFrame.ModelScene, "TOP", -260, -60)
			--right side
			_G.WardrobeTransmogFrame.ModelScene.HandsButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.HandsButton:SetPoint("TOP", _G.WardrobeTransmogFrame.ModelScene, "TOP", 250, -120)
			--main weapon
			_G.WardrobeTransmogFrame.ModelScene.MainHandButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.MainHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame.ModelScene, "BOTTOM", -50, 0)
			--offhand
			_G.WardrobeTransmogFrame.ModelScene.SecondaryHandButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.SecondaryHandButton:SetPoint("TOP", _G.WardrobeTransmogFrame.ModelScene, "BOTTOM", 50, 0)
			--and their enchants
			_G.WardrobeTransmogFrame.ModelScene.MainHandEnchantButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.MainHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.ModelScene.MainHandButton, "BOTTOM", 0, -28)
			_G.WardrobeTransmogFrame.ModelScene.SecondaryHandEnchantButton:ClearAllPoints()
			_G.WardrobeTransmogFrame.ModelScene.SecondaryHandEnchantButton:SetPoint("BOTTOM", _G.WardrobeTransmogFrame.ModelScene.SecondaryHandButton, "BOTTOM", 0, -28)
			_G.UIPanelWindows["WardrobeFrame"].width = 1200
		end
	end
end



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
			frame.dimOverlay = frame:CreateTexture(nil, "OVERLAY");
			frame.dimOverlay:SetColorTexture(0, 0, 0, 0.8);
			frame.dimOverlay:SetAllPoints();
			frame.dimOverlay:Hide();
		end

		for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do
			_G["PetStableStabledPet"..i]:ClearAllPoints()
			_G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -5)
		end

		PetStableNextPageButton:Hide()
		PetStablePrevPageButton:Hide()
		local widthDelta = 315
		local heightDelta = 204
		local f = CreateFrame("Frame", "ImprovedStableFrameSlots", PetStableFrame, "InsetFrameTemplate")
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

		local searchInput = CreateFrame("EditBox", "ISF_SearchInput", f, "SearchBoxTemplate")
		searchInput:SetPoint("TOPLEFT", 9, 0)
		searchInput:SetPoint("RIGHT", -3, 0)
		searchInput:SetHeight(20)

		local function ImprovedStableFrame_Update()
			local input = ISF_SearchInput:GetText()
			if not input or input:trim() == "" then
				for i = 1, maxSlots do
					local button = _G["PetStableStabledPet"..i];
					button.dimOverlay:Hide();
				end
				return
			end

			for i = 1, maxSlots do
				local icon, name, level, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i);
				local button = _G["PetStableStabledPet"..i];

				button.dimOverlay:Show();
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
						button.dimOverlay:Hide();
					end
				end
			end
		end
		searchInput:HookScript("OnTextChanged", ImprovedStableFrame_Update)
		searchInput.Instructions:SetText(SEARCH .. " (" .. NAME .. ", " .. PET_FAMILIES .. ", " .. PET_TALENTS  .. ")")
		hooksecurefunc("PetStable_Update", ImprovedStableFrame_Update)
		NUM_PET_STABLE_SLOTS = maxSlots
		NUM_PET_STABLE_PAGES = 1
		PetStableFrame.page = 1
		PetStableFrame:HookScript("OnShow", function()
			if not IsAddOnLoaded("ImprovedStableFrame") then
				LoadAddOn("ImprovedStableFrame")
			end
		end)
	end
end
