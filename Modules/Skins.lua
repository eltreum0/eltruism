local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent

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
				_G.PlayerTalentFrameScrollFrameScrollBar:Kill()
			end
			--increase the size of the whole frame
			if _G.PlayerTalentFrame then
				_G.PlayerTalentFrame:SetSize(376, 770)
			end
			if _G.PlayerTalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				_G.PlayerTalentFrameScrollFrame:SetSize( 280 , 570)
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
				_G.PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 590)
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
				_G.TalentFrameScrollFrameScrollBar:Kill()
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

function ElvUI_EltreumUI:SkinsInit()
	ElvUI_EltreumUI:Skins()
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
end
